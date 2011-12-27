APUbiquitousUserDefaultsEngine
==============================

APUbiquitousUserDefaultsEngine is a single class that syncs some keys of `NSUserDefaults` with iCloud, using `NSUbiquitousKeyValueStore` to store the values.

Features
--------

- Syncs a subset of `NSUserDefaults` keys, specified by the _ubiquitousKeys_ property.
- Can seed initial values to iCloud

How to use
----------

```APUbiquitousUserDefaultsEngine * engine = [APUbiquitousUserDefaultsEngine sharedEngine];
[engine setUbiquitousKeys:[NSSet setWithObjects:@"userPreference", nil]];
[engine pushUserDefaultsToiCloud];
[engine start];```

Licensing
---------

APUbiquitousUserDefaultsEngine is licensed under the following BSD license:

Copyright 2011 Axel Péju. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY AXEL PEJU ''AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL AXEL PEJU OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.