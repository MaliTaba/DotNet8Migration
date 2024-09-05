## NUnit Library Update

Update Nunit to version 4+ could require legacy assertion syntax update, such as:
```
Assert.IsTrue
Assert.True
Assert.AreEqual
```

Following reg expressions could help with some large changes

```
Assert.IsFalse\((.*), (.*)\);   ---> Assert.That($1, Is.False, $2);
Assert.IsFalse\((.*)\);         ---> Assert.That($1, Is.False);
Assert.False\((.*)\);           ---> Assert.That($1, Is.False);
Assert.IsTrue\((.*), (.*)\);    ---> Assert.That($1, Is.True, $2);
Assert.IsTrue\((.*)\);          ---> Assert.That($1, Is.True);
Assert.True\((.*)\);            ---> Assert.That($1, Is.True);
Assert.IsNotNull\((.*), (.*)\); ---> Assert.That($1, Is.Not.Null, $2);
Assert.IsNotNull\((.*)\);       ---> Assert.That($1, Is.Not.Null);
Assert.IsNull\((.*)\);          ---> Assert.That($1, Is.Null);
Assert.AreEqual\((.*), (.*)\);  ---> Assert.That($2, Is.EqualTo($1));
Assert.IsEmpty\((.*)\);         ---> Assert.That($1, Is.Empty);
Assert.IsNotEmpty\((.*)\);      ---> Assert.That($1, Is.Not.Empty);```