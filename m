From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Passing LUA script via python rados execute
Date: Thu, 16 Feb 2017 13:00:53 -0800
Message-ID: <CAB2gnbVXVUiCgBFK2Q4+8N=RVf6KLGjH=_oibb+BJxx0B_FmtA@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
 <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com> <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f171.google.com ([74.125.82.171]:33976 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933142AbdBPVAz (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 16:00:55 -0500
Received: by mail-ot0-f171.google.com with SMTP id t47so19651974ota.1
        for <ceph-devel@vger.kernel.org>; Thu, 16 Feb 2017 13:00:55 -0800 (PST)
In-Reply-To: <3177d648.AEQAH1DOmSwAAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYphEb@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nick Fisk <nick@fisk.me.uk>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

It looks like you might be using a script / example that was written
before the code was merged into Ceph and might be a little out of
date. Use `objclass.register` instead of `cls.register`. There is a
test script at the top of
https://github.com/ceph/ceph/blob/master/src/test/cls_lua/test_cls_lua.cc
that you can use as a reference. If the test programs are installed
you should also have the executable `ceph_test_cls_lua` which will run
the cls_lua unit tests.

On Thu, Feb 16, 2017 at 12:52 PM, Nick Fisk <nick@fisk.me.uk> wrote:
> Hi Noah,
>
> Thanks for the response.
>
> You were right about the need to enable the class in the ceph.conf. I did=
 see that note in the Kraken release notes, but assumed that as the LUA cla=
ss is in the Ceph source tree now, that it would have been included with al=
l the others in that directory. Anyway slap on the wrist for me not checkin=
g that.
>
> However, although that got me a bit further, I'm now getting a read error
>
> rados.IOError: Ioctx.read(rbd): failed to read test
>
> Which is a bit puzzling. As there is definitely an object called test on =
the rbd pool and if I issue a ioctx.read right before the execute call, it =
returns successfully with the objects contents. So I'm guessing this is act=
ually the lua class/script bombing out and not a read error?
>
> I also get this error in the OSD log
>
> 2017-02-16 20:41:45.065617 7f08da336700  0 <cls> /tmp/buildd/ceph-11.2.0/=
src/cls/lua/cls_lua.cc:1004: error: [string "..."]:7: attempt to index a ni=
l value (global 'cls')
>
> Don't know if that rings any bells?
>
> Nick
>
>> -----Original Message-----
>> From: Noah Watkins [mailto:noahwatkins@gmail.com]
>> Sent: 15 February 2017 23:43
>> To: nick@fisk.me.uk
>> Cc: ceph-devel <ceph-devel@vger.kernel.org>
>> Subject: Re: Passing LUA script via python rados execute
>>
>> Hi Nick,
>>
>> First thing to note is that in Kraken that object classes not whiteliste=
d need to
>> be enabled explicitly. This is in the Kraken release notes
>> (http://docs.ceph.com/docs/master/release-notes/):
>>
>> tldr: add 'osd class load list =3D *' and 'osd class default list =3D *'
>> to ceph.conf.
>>
>> - The =E2=80=98osd class load list=E2=80=99 config option is a list of o=
bject class names that the
>> OSD is permitted to load (or =E2=80=98*=E2=80=99 for all classes). By de=
fault it contains all
>> existing in-tree classes for backwards compatibility.
>>
>> - The =E2=80=98osd class default list=E2=80=99 config option is a list o=
f object class names (or =E2=80=98*=E2=80=99
>> for all classes) that clients may invoke having only the =E2=80=98*=E2=
=80=99, =E2=80=98x=E2=80=99, =E2=80=98class-read=E2=80=99, or
>> =E2=80=98class-write=E2=80=99 capabilities. By default it contains all e=
xisting in-tree classes for
>> backwards compatibility.
>> Invoking classes not listed in =E2=80=98osd class default list=E2=80=99 =
requires a capability
>> naming the class (e.g. =E2=80=98allow class foo=E2=80=99).
>>
>> I suspect that will resolve the issue.
>>
>> If you've done that and it still doesn't work then the next thing I'd su=
ggest is
>> creating the target object before running the command.
>> Operations on objects that don't exist sometimes seem non-intuitive to m=
e.
>>
>> Let me know if that doesn't work and we can look at debugging further.
>>
>> Thanks,
>> - Noah
>>
>> On Wed, Feb 15, 2017 at 1:11 PM, Nick Fisk <nick@fisk.me.uk> wrote:
>> > Hi Noah,
>> >
>> > I'm trying to follow your example where you can pass a LUA script as
>> > json when calling the rados execute function in Python. However I'm
>> > getting a rados permission denied error saying its failed to read the
>> > test object I have placed on the pool.
>> >
>> > I have also tried calling the cls_hello object class and this works,
>> > so I believe its something to do with the LUA functionality that's
>> > causing it to bomb out. This is running on Kraken.
>> >
>> > Any ideas would be gratefully received.
>> >
>> > Nick
>> >
>> > Ie
>> > print json.dumps(cmd)
>> > ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.dumps(cmd=
))
>> >
>> > Outputs
>> > python radoslua.py --object-name=3Dtest --pool=3Drbd
>> > {"handler": "upper", "script": "\n      function upper(input, output)\=
n
>> > input_str =3D input:str()\n        upper_str =3D string.upper(input_st=
r)\n
>> > output:append(upper_str)\n      end\n      cls.register(upper)\n  "}
>> > Traceback (most recent call last):
>> >   File "radoslua.py", line 47, in <module>
>> >     ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.dumps=
(cmd))
>> >   File "rados.pyx", line 451, in rados.requires.wrapper.validate_func
>> > (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/r
>> > ados.c
>> > :4439)
>> >   File "rados.pyx", line 2657, in rados.Ioctx.execute
>> > (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/r
>> > ados.c
>> > :34056)
>> > rados.PermissionError: Ioctx.read(rbd): failed to read test
>> >
>
