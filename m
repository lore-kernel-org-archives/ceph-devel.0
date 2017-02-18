From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Passing LUA script via python rados execute
Date: Sat, 18 Feb 2017 15:58:34 -0800
Message-ID: <CAB2gnbVyxNzfrf7dkaP=HzXS1juZ2R6fZrXpJbijzDiOXdUrpQ@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
 <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
 <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
 <CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com>
 <1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
 <CAB2gnbW1_TLmYsszA7KTD18NdNhW5HR44bvCknTs9rqX007s7Q@mail.gmail.com>
 <3a5eb209.AEEAIECau6cAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYp3rL@mailjet.com>
 <CAB2gnbWXWcj=O1LKKMGCn2X6h_T46x9Ypaupy2u7wQHdBV2CJA@mail.gmail.com> <5ad9bb93.AEQAH3DlQ6gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYqM0y@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:36587 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750785AbdBRX6f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 18 Feb 2017 18:58:35 -0500
Received: by mail-oi0-f43.google.com with SMTP id u143so38729279oif.3
        for <ceph-devel@vger.kernel.org>; Sat, 18 Feb 2017 15:58:35 -0800 (PST)
In-Reply-To: <5ad9bb93.AEQAH3DlQ6gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYqM0y@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, ceph-users <ceph-users@lists.ceph.com>

On Sat, Feb 18, 2017 at 2:39 PM, Nick Fisk <nick@fisk.me.uk> wrote:

> My use case is more for learning, rather than an actual working project. =
I thought it was a really elegant way of harnessing the distributed power o=
f Ceph and wanted to learn more. For this example I wanted to do something =
like calculate an MD5 hash of all the objects in the pool and compare speed=
/overheads to doing it via a client. But I can see that if you can't load m=
odules, then you are either going to have to pass very large scripts every =
execution, or be limited in what you can achieve with lua.

Most of the examples I've worked on don't rely on any external
dependencies, although the blog posts highlight things like MD5 only
because they are a bit more concise to describe.

>
> Option 1 doesn=E2=80=99t sound like too much of a faff to me. I think a l=
ot of people use stuff like Ansible to mange Ceph anyway, so pushing out LU=
A libs and keeping them consistent shouldn't be too much of a task and it s=
ounds like it would be a lot simpler to implement. I installed the LUA MD5 =
module via apt, so at least some of them would be really easy to keep in sy=
nc.

Sounds good. I'll put together a patch that adds a sandbox escape
option, and then see what people think.

>
> Although what you've said I option 2 does sound really good, I can see a =
lot of scenarios where that would be really useful to simply push the scrip=
t/modules into an object. I guess my only concerns would be around security=
. Ie if the "script" object is in the same pool as the objects to be worked=
 on, then in theory could someone modify the script object to do something =
nasty, intentional or not.
>

Security is a concern, though in general either applications at this
level (ie. invoking object classes) are already trusted, or an
application could assert a known version of a set of objects that is
enforced automatically.

> Nick
>
>> -----Original Message-----
>> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> Sent: 18 February 2017 19:56
>> To: Nick Fisk <nick@fisk.me.uk>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>; Patrick Donnelly
>> <pdonnell@redhat.com>; ceph-users <ceph-users@lists.ceph.com>
>> Subject: Re: Passing LUA script via python rados execute
>>
>> Hi Nick,
>>
>> The short answer to your question is that barring a hole in the sandbox =
(or
>> loading a modified version of the plugin which is an option), any
>> dependencies need to be packaged up into the the request and can't be
>> loaded dynamically from the host file system. In version
>> 1 of the Lua plugin we wanted to lock down the sandbox, but knew we'd
>> have to address expanded use cases. I guess that time is now :)
>>
>> What follows are my initial thoughts on a version 2 of the plugin. I'd l=
ike to
>> get feedback on these changes in the context of your use case.
>> I've also CC'd Patrick Donnelly, who I hope can chime in too with his op=
inion.
>>
>> The least intrusive solution is to simply change the sandbox to allow th=
e
>> standard file system module loading function as expected. Then any user
>> would need to make sure that every OSD had consistent versions of
>> dependencies installed using something like LuaRocks. This is simple, bu=
t
>> could make debugging and deployment a major headache.
>>
>> A more ambitious version would be to create an interface for users to up=
load
>> scripts and dependencies into objects, and support referencing those obj=
ects
>> as standard dependencies in Lua scripts as if they were standard modules=
 on
>> the file system. Each OSD could then cache scripts and dependencies,
>> allowing applications to use references to scripts instead of sending a =
script
>> with every request.
>>
>> In the short term we can add a configuration parameter to allow the sand=
box
>> to access the file system, but I'm not familiar with the policies of bac=
kporting
>> these types of changes.
>>
>> Thoughts?
>> -Noah
>>
>> On Fri, Feb 17, 2017 at 2:35 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> > Hi Noah,
>> >
>> > One last question, I think.
>> > Is it possible to use the require statement to load extra modules into=
 the
>> lua script, if that module exists somewhere on the OSD nodes local FS?
>> >
>> > I'm trying to load a lua md5 module in, like:
>> > cmd =3D {
>> >   "script": """
>> >       local md5 =3D require "md5"
>> >       function calcmd5(input, output)
>> > ...
>> >
>> > and I'm getting
>> >
>> > <cls> /tmp/buildd/ceph-11.2.0/src/cls/lua/cls_lua.cc:1004: error:
>> > [string "..."]:2: attempt to call a nil value (global 'require')
>> >
>> > I did see this comment
>> >
>> > https://github.com/ceph/ceph/blob/kraken/src/cls/lua/cls_lua.cc#L703
>> >
>> > So not sure if that means currently loading modules from the local FS =
is
>> restricted?
>> >
>> > Thanks
>> > Nick
>> >
>> >
>> >> -----Original Message-----
>> >> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> >> Sent: 16 February 2017 22:17
>> >> To: Nick Fisk <nick@fisk.me.uk>
>> >> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> >> Subject: Re: Passing LUA script via python rados execute
>> >>
>> >> Sorry about the confusion. Let us know if you have any issues /
>> >> questions :)
>> >>
>> >> On Thu, Feb 16, 2017 at 1:05 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> >> > Bingo!!
>> >> >
>> >> > That was it, I was just using the example from here
>> >> >
>> >> > http://noahdesu.github.io/2015/12/06/load-lua-rados-plugin-from-fs.
>> >> > htm
>> >> > l
>> >> >
>> >> > cmd =3D {
>> >> >   "script": """
>> >> >       function upper(input, output)
>> >> >         input_str =3D input:str()
>> >> >         upper_str =3D string.upper(input_str)
>> >> >         output:append(upper_str)
>> >> >       end
>> >> >       cls.register(upper)
>> >> >   """,
>> >> >   "handler": "upper",
>> >> >   "input": "this string was in lower case", }
>> >> >
>> >> > Thanks for all your help on this.
>> >> >
>> >> > Nick
>> >> >
>> >> >> -----Original Message-----
>> >> >> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> >> >> Sent: 16 February 2017 21:01
>> >> >> To: Nick Fisk <nick@fisk.me.uk>
>> >> >> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> >> >> Subject: Re: Passing LUA script via python rados execute
>> >> >>
>> >> >> It looks like you might be using a script / example that was
>> >> >> written before the code was merged into Ceph and might be a little
>> >> >> out of date. Use `objclass.register` instead of `cls.register`.
>> >> >> There is a test script at the top of
>> >> >> https://github.com/ceph/ceph/blob/master/src/test/cls_lua/test_cls
>> >> >> _lu a.cc that you can use as a reference. If the test programs are
>> >> >> installed you should also have the executable `ceph_test_cls_lua`
>> >> >> which will run the cls_lua unit tests.
>> >> >>
>> >> >> On Thu, Feb 16, 2017 at 12:52 PM, Nick Fisk <nick@fisk.me.uk> wrot=
e:
>> >> >> > Hi Noah,
>> >> >> >
>> >> >> > Thanks for the response.
>> >> >> >
>> >> >> > You were right about the need to enable the class in the ceph.co=
nf.
>> >> >> > I did
>> >> >> see that note in the Kraken release notes, but assumed that as the
>> >> >> LUA class is in the Ceph source tree now, that it would have been
>> >> >> included with all the others in that directory. Anyway slap on the
>> >> >> wrist for
>> >> me not checking that.
>> >> >> >
>> >> >> > However, although that got me a bit further, I'm now getting a
>> >> >> > read error
>> >> >> >
>> >> >> > rados.IOError: Ioctx.read(rbd): failed to read test
>> >> >> >
>> >> >> > Which is a bit puzzling. As there is definitely an object called
>> >> >> > test on the rbd
>> >> >> pool and if I issue a ioctx.read right before the execute call, it
>> >> >> returns successfully with the objects contents. So I'm guessing
>> >> >> this is actually the lua class/script bombing out and not a read e=
rror?
>> >> >> >
>> >> >> > I also get this error in the OSD log
>> >> >> >
>> >> >> > 2017-02-16 20:41:45.065617 7f08da336700  0 <cls>
>> >> >> > /tmp/buildd/ceph-11.2.0/src/cls/lua/cls_lua.cc:1004: error:
>> >> >> > [string
>> >> >> > "..."]:7: attempt to index a nil value (global 'cls')
>> >> >> >
>> >> >> > Don't know if that rings any bells?
>> >> >> >
>> >> >> > Nick
>> >> >> >
>> >> >> >> -----Original Message-----
>> >> >> >> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> >> >> >> Sent: 15 February 2017 23:43
>> >> >> >> To: nick@fisk.me.uk
>> >> >> >> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> >> >> >> Subject: Re: Passing LUA script via python rados execute
>> >> >> >>
>> >> >> >> Hi Nick,
>> >> >> >>
>> >> >> >> First thing to note is that in Kraken that object classes not
>> >> >> >> whitelisted need to be enabled explicitly. This is in the
>> >> >> >> Kraken release notes
>> >> >> >> (http://docs.ceph.com/docs/master/release-notes/):
>> >> >> >>
>> >> >> >> tldr: add 'osd class load list =3D *' and 'osd class default li=
st =3D *'
>> >> >> >> to ceph.conf.
>> >> >> >>
>> >> >> >> - The =E2=80=98osd class load list=E2=80=99 config option is a =
list of object
>> >> >> >> class names that the OSD is permitted to load (or =E2=80=98*=E2=
=80=99 for all
>> >> >> >> classes). By default it contains all existing in-tree classes
>> >> >> >> for backwards
>> >> compatibility.
>> >> >> >>
>> >> >> >> - The =E2=80=98osd class default list=E2=80=99 config option is=
 a list of
>> >> >> >> object class names (or
>> >> >> =E2=80=98*=E2=80=99
>> >> >> >> for all classes) that clients may invoke having only the =E2=80=
=98*=E2=80=99,
>> >> >> >> =E2=80=98x=E2=80=99, =E2=80=98class-read=E2=80=99, or =E2=80=98=
class-write=E2=80=99 capabilities. By default it
>> >> >> >> contains all existing in-tree classes for backwards compatibili=
ty.
>> >> >> >> Invoking classes not listed in =E2=80=98osd class default list=
=E2=80=99
>> >> >> >> requires a capability naming the class (e.g. =E2=80=98allow cla=
ss foo=E2=80=99).
>> >> >> >>
>> >> >> >> I suspect that will resolve the issue.
>> >> >> >>
>> >> >> >> If you've done that and it still doesn't work then the next
>> >> >> >> thing I'd suggest is creating the target object before running =
the
>> command.
>> >> >> >> Operations on objects that don't exist sometimes seem
>> >> >> >> non-intuitive to
>> >> >> me.
>> >> >> >>
>> >> >> >> Let me know if that doesn't work and we can look at debugging
>> further.
>> >> >> >>
>> >> >> >> Thanks,
>> >> >> >> - Noah
>> >> >> >>
>> >> >> >> On Wed, Feb 15, 2017 at 1:11 PM, Nick Fisk <nick@fisk.me.uk>
>> wrote:
>> >> >> >> > Hi Noah,
>> >> >> >> >
>> >> >> >> > I'm trying to follow your example where you can pass a LUA
>> >> >> >> > script as json when calling the rados execute function in
>> >> >> >> > Python. However I'm getting a rados permission denied error
>> >> >> >> > saying its failed to read the test object I have placed on th=
e pool.
>> >> >> >> >
>> >> >> >> > I have also tried calling the cls_hello object class and this
>> >> >> >> > works, so I believe its something to do with the LUA
>> >> >> >> > functionality that's causing it to bomb out. This is running =
on
>> Kraken.
>> >> >> >> >
>> >> >> >> > Any ideas would be gratefully received.
>> >> >> >> >
>> >> >> >> > Nick
>> >> >> >> >
>> >> >> >> > Ie
>> >> >> >> > print json.dumps(cmd)
>> >> >> >> > ret, data =3D ioctx.execute('test', 'lua', 'eval_json',
>> >> >> >> > json.dumps(cmd))
>> >> >> >> >
>> >> >> >> > Outputs
>> >> >> >> > python radoslua.py --object-name=3Dtest --pool=3Drbd
>> >> >> >> > {"handler": "upper", "script": "\n      function upper(input,
>> output)\n
>> >> >> >> > input_str =3D input:str()\n        upper_str =3D string.upper=
(input_str)\n
>> >> >> >> > output:append(upper_str)\n      end\n      cls.register(upper=
)\n  "}
>> >> >> >> > Traceback (most recent call last):
>> >> >> >> >   File "radoslua.py", line 47, in <module>
>> >> >> >> >     ret, data =3D ioctx.execute('test', 'lua', 'eval_json',
>> json.dumps(cmd))
>> >> >> >> >   File "rados.pyx", line 451, in
>> >> >> >> > rados.requires.wrapper.validate_func
>> >> >> >> > (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rado
>> >> >> >> > s/p
>> >> >> >> > yre
>> >> >> >> > x/r
>> >> >> >> > ados.c
>> >> >> >> > :4439)
>> >> >> >> >   File "rados.pyx", line 2657, in rados.Ioctx.execute
>> >> >> >> > (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rado
>> >> >> >> > s/p
>> >> >> >> > yre
>> >> >> >> > x/r
>> >> >> >> > ados.c
>> >> >> >> > :34056)
>> >> >> >> > rados.PermissionError: Ioctx.read(rbd): failed to read test
>> >> >> >> >
>> >> >> >
>> >> >
>> >
>
