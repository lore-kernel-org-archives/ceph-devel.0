From: Noah Watkins <noahwatkins@gmail.com>
Subject: Re: Passing LUA script via python rados execute
Date: Wed, 15 Feb 2017 15:42:37 -0800
Message-ID: <CAB2gnbXykgX42up7ZzT-e5UvZrRkpyzAnGP_D4CnH-AgFRW8qg@mail.gmail.com>
References: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ot0-f174.google.com ([74.125.82.174]:33645 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755797AbdBOXmn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 18:42:43 -0500
Received: by mail-ot0-f174.google.com with SMTP id 73so1206570otj.0
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 15:42:38 -0800 (PST)
In-Reply-To: <1fa1fa7d.AEEAIBzI4F8AAAAAAAAAAF3gdzcAADNJBWwAAAAAAACRXwBYpMPz@mailjet.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: nick@fisk.me.uk
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Nick,

First thing to note is that in Kraken that object classes not
whitelisted need to be enabled explicitly. This is in the Kraken
release notes (http://docs.ceph.com/docs/master/release-notes/):

tldr: add 'osd class load list =3D *' and 'osd class default list =3D *'
to ceph.conf.

- The =E2=80=98osd class load list=E2=80=99 config option is a list of obje=
ct class
names that the OSD is permitted to load (or =E2=80=98*=E2=80=99 for all cla=
sses). By
default it contains all existing in-tree classes for backwards
compatibility.

- The =E2=80=98osd class default list=E2=80=99 config option is a list of o=
bject class
names (or =E2=80=98*=E2=80=99 for all classes) that clients may invoke havi=
ng only the
=E2=80=98*=E2=80=99, =E2=80=98x=E2=80=99, =E2=80=98class-read=E2=80=99, or =
=E2=80=98class-write=E2=80=99 capabilities. By default it
contains all existing in-tree classes for backwards compatibility.
Invoking classes not listed in =E2=80=98osd class default list=E2=80=99 req=
uires a
capability naming the class (e.g. =E2=80=98allow class foo=E2=80=99).

I suspect that will resolve the issue.

If you've done that and it still doesn't work then the next thing I'd
suggest is creating the target object before running the command.
Operations on objects that don't exist sometimes seem non-intuitive to
me.

Let me know if that doesn't work and we can look at debugging further.

Thanks,
- Noah

On Wed, Feb 15, 2017 at 1:11 PM, Nick Fisk <nick@fisk.me.uk> wrote:
> Hi Noah,
>
> I'm trying to follow your example where you can pass a LUA script as json
> when calling the rados execute function in Python. However I'm getting a
> rados permission denied error saying its failed to read the test object I
> have placed on the pool.
>
> I have also tried calling the cls_hello object class and this works, so I
> believe its something to do with the LUA functionality that's causing it =
to
> bomb out. This is running on Kraken.
>
> Any ideas would be gratefully received.
>
> Nick
>
> Ie
> print json.dumps(cmd)
> ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.dumps(cmd))
>
> Outputs
> python radoslua.py --object-name=3Dtest --pool=3Drbd
> {"handler": "upper", "script": "\n      function upper(input, output)\n
> input_str =3D input:str()\n        upper_str =3D string.upper(input_str)\=
n
> output:append(upper_str)\n      end\n      cls.register(upper)\n  "}
> Traceback (most recent call last):
>   File "radoslua.py", line 47, in <module>
>     ret, data =3D ioctx.execute('test', 'lua', 'eval_json', json.dumps(cm=
d))
>   File "rados.pyx", line 451, in rados.requires.wrapper.validate_func
> (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/rado=
s.c
> :4439)
>   File "rados.pyx", line 2657, in rados.Ioctx.execute
> (/tmp/buildd/ceph-11.2.0/obj-x86_64-linux-gnu/src/pybind/rados/pyrex/rado=
s.c
> :34056)
> rados.PermissionError: Ioctx.read(rbd): failed to read test
>
