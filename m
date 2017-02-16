From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Passing LUA script via python rados execute
Date: Thu, 16 Feb 2017 14:17:11 -0800
Message-ID: <CAB2gnbW1_TLmYsszA7KTD18NdNhW5HR44bvCknTs9rqX007s7Q@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
 <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
 <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
 <CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com> <1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f177.google.com ([74.125.82.177]:36517 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933577AbdBPWRM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 17:17:12 -0500
Received: by mail-ot0-f177.google.com with SMTP id 32so20870970oth.3
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 14:17:12 -0800 (PST)
In-Reply-To: <1cadb44c.ADsAAGb8C0gAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphQY@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Sorry about the confusion. Let us know if you have any issues / questions :=
)

On Thu, Feb 16, 2017 at 1:05 PM, Nick Fisk <nick@fisk.me.uk> wrote:
> Bingo!!
>
> That was it, I was just using the example from here
>
> http://noahdesu.github.io/2015/12/06/load-lua-rados-plugin-from-fs.html
>
> cmd =3D {
>   "script": """
>       function upper(input, output)
>         input_str =3D input:str()
>         upper_str =3D string.upper(input_str)
>         output:append(upper_str)
>       end
>       cls.register(upper)
>   """,
>   "handler": "upper",
>   "input": "this string was in lower case",
> }
>
> Thanks for all your help on this.
>
> Nick
>
>> -----Original Message-----
>> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> Sent: 16 February 2017 21:01
>> To: Nick Fisk <nick@fisk.me.uk>
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: Re: Passing LUA script via python rados execute
>>
>> It looks like you might be using a script / example that was written bef=
ore the
>> code was merged into Ceph and might be a little out of date. Use
>> `objclass.register` instead of `cls.register`. There is a test script at=
 the top of
>> https://github.com/ceph/ceph/blob/master/src/test/cls_lua/test_cls_lua.c=
c
>> that you can use as a reference. If the test programs are installed you =
should
>> also have the executable `ceph_test_cls_lua` which will run the cls_lua =
unit
>> tests.
>>
>> On Thu, Feb 16, 2017 at 12:52 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> > Hi Noah,
>> >
>> > Thanks for the response.
>> >
>> > You were right about the need to enable the class in the ceph.conf. I =
did
>> see that note in the Kraken release notes, but assumed that as the LUA c=
lass
>> is in the Ceph source tree now, that it would have been included with al=
l the
>> others in that directory. Anyway slap on the wrist for me not checking t=
hat.
>> >
>> > However, although that got me a bit further, I'm now getting a read
>> > error
>> >
>> > rados.IOError: Ioctx.read(rbd): failed to read test
>> >
>> > Which is a bit puzzling. As there is definitely an object called test =
on the rbd
>> pool and if I issue a ioctx.read right before the execute call, it retur=
ns
>> successfully with the objects contents. So I'm guessing this is actually=
 the lua
>> class/script bombing out and not a read error?
>> >
>> > I also get this error in the OSD log
>> >
>> > 2017-02-16 20:41:45.065617 7f08da336700  0 <cls>
>> > /tmp/buildd/ceph-11.2.0/src/cls/lua/cls_lua.cc:1004: error: [string
>> > "..."]:7: attempt to index a nil value (global 'cls')
>> >
>> > Don't know if that rings any bells?
>> >
>> > Nick
>> >
>> >> -----Original Message-----
>> >> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> >> Sent: 15 February 2017 23:43
>> >> To: nick@fisk.me.uk
>> >> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> >> Subject: Re: Passing LUA script via python rados execute
>> >>
>> >> Hi Nick,
>> >>
>> >> First thing to note is that in Kraken that object classes not
>> >> whitelisted need to be enabled explicitly. This is in the Kraken
>> >> release notes
>> >> (http://docs.ceph.com/docs/master/release-notes/):
>> >>
>> >> tldr: add 'osd class load list =3D *' and 'osd class default list =3D=
 *'
>> >> to ceph.conf.
>> >>
>> >> - The =E2=80=98osd class load list=E2=80=99 config option is a list o=
f object class
>> >> names that the OSD is permitted to load (or =E2=80=98*=E2=80=99 for a=
ll classes). By
>> >> default it contains all existing in-tree classes for backwards compat=
ibility.
>> >>
>> >> - The =E2=80=98osd class default list=E2=80=99 config option is a lis=
t of object class names (or
>> =E2=80=98*=E2=80=99
>> >> for all classes) that clients may invoke having only the =E2=80=98*=
=E2=80=99, =E2=80=98x=E2=80=99,
>> >> =E2=80=98class-read=E2=80=99, or =E2=80=98class-write=E2=80=99 capabi=
lities. By default it contains
>> >> all existing in-tree classes for backwards compatibility.
>> >> Invoking classes not listed in =E2=80=98osd class default list=E2=80=
=99 requires a
>> >> capability naming the class (e.g. =E2=80=98allow class foo=E2=80=99).
>> >>
>> >> I suspect that will resolve the issue.
>> >>
>> >> If you've done that and it still doesn't work then the next thing I'd
>> >> suggest is creating the target object before running the command.
>> >> Operations on objects that don't exist sometimes seem non-intuitive t=
o
>> me.
>> >>
>> >> Let me know if that doesn't work and we can look at debugging further=
.
>> >>
>> >> Thanks,
>> >> - Noah
>> >>
>> >> On Wed, Feb 15, 2017 at 1:11 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> >> > Hi Noah,
>> >> >
>> >> > I'm trying to follow your example where you can pass a LUA script
>> >> > as json when calling the rados execute function in Python. However
>> >> > I'm getting a rados permission denied error saying its failed to
>> >> > read the test object I have placed on the pool.
>> >> >
>> >> > I have also tried calling the cls_hello object class and this
>> >> > works, so I believe its something to do with the LUA functionality
>> >> > that's causing it to bomb out. This is running on Kraken.
>> >> >
>> >> > Any ideas would be gratefully received.
>> >> >
>> >> > Nick
>> >> >
>> >> > Ie
>> >> > print json.dumps(cmd)
>> >> > ret, data =3D ioctx.execute('test', 'lua', 'eval_json',
>> >> > json.dumps(cmd))
>> >> >
>> >> > Outputs
>> >> > python radoslua.py --object-name=3Dtest --pool=3Drbd
>> >> > {"handler": "upper", "script": "\n      function upper(input, outpu=
t)\n
>> >> > input_str =3D input:str()\n        upper_str =3D string.upper(input=
_str)\n
>> >> > output:append(upper_str)\n      end\n      cls.register(upper)\n  "=
}
>> >> > Traceback (most recent call last):
>> >> >   File "radoslua.py", line 47, in <module>
>> >> >     ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.du=
mps(cmd))
>> >> >   File "rados.pyx", line 451, in
>> >> > rados.requires.wrapper.validate_func
>> >> > (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyre
>> >> > x/r
>> >> > ados.c
>> >> > :4439)
>> >> >   File "rados.pyx", line 2657, in rados.Ioctx.execute
>> >> > (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyre
>> >> > x/r
>> >> > ados.c
>> >> > :34056)
>> >> > rados.PermissionError: Ioctx.read(rbd): failed to read test
>> >> >
>> >
>
