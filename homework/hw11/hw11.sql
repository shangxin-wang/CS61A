CREATE TABLE parents AS
  SELECT "abraham" AS parent, "barack" AS child UNION
  SELECT "abraham"          , "clinton"         UNION
  SELECT "delano"           , "herbert"         UNION
  SELECT "fillmore"         , "abraham"         UNION
  SELECT "fillmore"         , "delano"          UNION
  SELECT "fillmore"         , "grover"          UNION
  SELECT "eisenhower"       , "fillmore";

CREATE TABLE dogs AS
  SELECT "abraham" AS name, "long" AS fur, 26 AS height UNION
  SELECT "barack"         , "short"      , 52           UNION
  SELECT "clinton"        , "long"       , 47           UNION
  SELECT "delano"         , "long"       , 46           UNION
  SELECT "eisenhower"     , "short"      , 35           UNION
  SELECT "fillmore"       , "curly"      , 32           UNION
  SELECT "grover"         , "short"      , 28           UNION
  SELECT "herbert"        , "curly"      , 31;

CREATE TABLE sizes AS
  SELECT "toy" AS size, 24 AS min, 28 AS max UNION
  SELECT "mini"       , 28       , 35        UNION
  SELECT "medium"     , 35       , 45        UNION
  SELECT "standard"   , 45       , 60;

-------------------------------------------------------------
-- PLEASE DO NOT CHANGE ANY SQL STATEMENTS ABOVE THIS LINE --
-------------------------------------------------------------

-- The size of each dog
CREATE TABLE size_of_dogs AS
  SELECT d.name, s.size from dogs as d, sizes as s
    where d.height > s.min and d.height <=s.max;

-- All dogs with parents ordered by decreasing height of their parent
CREATE TABLE by_parent_height AS
  SELECT child from parents, dogs as d
    where parent = d.name order by d.height DESC;

-- Filling out this helper table is optional
CREATE TABLE siblings AS
  SELECT m.child as siblings1, n.child as siblings2 from parents as m, parents as n
    where m.parent = n.parent and m.child <> n.child;

-- Sentences about siblings that are the same size
CREATE TABLE sentences AS
  SELECT k.siblings1 || " and " || k.siblings2 || " are " || w.size || " siblings"
    from siblings as k, size_of_dogs as w, size_of_dogs as z
    where k.siblings1 = w.name and
          k.siblings2 = z.name and
          w.size = z.size
          and k.siblings1 < k.siblings2;

-- Ways to stack 4 dogs to a height of at least 170, ordered by total height
CREATE TABLE stacks_helper(dogs, stack_height, last_height);

-- Add your INSERT INTOs here
INSERT INTO stacks_helper select name, height, height
                            from dogs
                            order by height;
INSERT INTO stacks_helper select a.dogs || ", " || b.dogs, a.last_height + b.last_height, b.last_height
                            from stacks_helper as a,stacks_helper as b
                            where a.dogs <> b.dogs and a.last_height < b.last_height
                            order by a.last_height + b.last_height;
INSERT INTO stacks_helper select a.name || ", " || b.name || ", " || c.name, a.height + b.height + c.height, c.height
                            from dogs as a, dogs as b, dogs as c
                            where a.name <> b.name and a.name <> c.name and b.name <> c.name
                                  and a.height < b.height and b.height < c.height
                            order by a.height + b.height + c.height;
INSERT INTO stacks_helper select a.name || ", " || b.name || ", " || c.name || ", " || d.name,
                                 a.height + b.height + c.height + d.height, d.height
                            from dogs as a, dogs as b, dogs as c, dogs as d
                            where a.name <> b.name and a.name <> c.name and a.name <> d.name and b.name <> c.name
                                  and b.name <> c.name and b.name <> d.name and c.name <> d.name
                                  and a.height < b.height and b.height < c.height and c.height < d.height
                            order by a.height + b.height + c.height + d.height;



CREATE TABLE stacks AS
  SELECT dogs, stack_height from stacks_helper where stack_height >= 170 order by stack_height;
