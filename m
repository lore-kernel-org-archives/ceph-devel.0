From: Lokesh Krishnappa <lokesh.professional.it@gmail.com>
Subject: Re: [ceph-commit] teuthology value error
Date: Wed, 3 Oct 2012 18:06:28 +0530
Message-ID: <CABpo6h+VV8mP_DA8DvFKzMDqdxcz48OeRVNiP6wvjHrDi=8KiA@mail.gmail.com>
References: <CABpo6hJZPKt1p1g4yC+KviC4Wr6OKuffcNGyVL9UeoJe8K+TDA@mail.gmail.com>
	<CAPYLRzice5K7H1W6baizm0EK=J9nAZX4Hm5FcVETB8_ikyDp4Q@mail.gmail.com>
	<CADvuQRF+8OQs2BGmKGe3k=OmZ91a8arD_fdZmLHZhzi1UmNq1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62358 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753865Ab2JCMg3 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Oct 2012 08:36:29 -0400
Received: by obbuo13 with SMTP id uo13so7186507obb.19
        for <ceph-devel@vger.kernel.org>; Wed, 03 Oct 2012 05:36:28 -0700 (PDT)
In-Reply-To: <CADvuQRF+8OQs2BGmKGe3k=OmZ91a8arD_fdZmLHZhzi1UmNq1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Tommi Virtanen <tv@inktank.com>

Hi all,

Am new to git and playing around git qa suite , trying to test rbd on
local machine .
and local test bed setup as ;

OS :  Ubuntu 12.04LTS
teuthology version: 0.0.1
ceph : 0.48.1 arganaut

we are running server, and the client on locale in a single machine .
yaml file format :
roles:
- [mon.a, osd.0, osd.1]

targets:
   lokesh@lokesh: ssh-rsa
AAAAB3NzaC1yc2EAAAADAQABAAABAQDmSb/VpYpdSQLp4unsKUNV/DKV2f55M1QSXHu10Qv=
co33rYopOF/l5+eYlINCHF1v/SA+bLOMT/4OHGkZR67TajAoXFpyolVSxZKRoJHLV2iJ+Mr=
RiaxShctMYWpLOjc4iRA4BG3FTG5TTPKJweDj8dDdUIqZ9PuSpP5VuOriCpQkPWECL2hJqA=
YwnknK1Uhg3rYV0XxL14Iep9KCZf2PcJNw3Eur6XKDAczu/sAUlOiLrBsQpFmOaPY5jFDaM=
3U7KpJvqiI4Drq331iMh9n3GuA+JvcTMKuT7CN36GswlvGuakTzaDoR66JaYYKkGzDl977K=
94XrAdQwa2NKLu1XH


tasks:
- ceph:
- ceph-fuse:
- workunit:
    clients:
      client.0:
        - rbd/test_cls_rbd.sh
#-interactive-on-error: true

and my .teutholgy.yaml file format is:

lock_server: http://lokesh/lock
queue_host: lokesh
queue_port: 4000

while am trying to execute test suite as:
lokesh@lokesh:~/Downloads/ceph-teuthology-78b7b02$
=2E/virtualenv/bin/teuthology rbd_cls_tests1.yaml

i met error as:
INFO:teuthology.run_tasks:Running task internal.save_config...
INFO:teuthology.task.internal:Saving configuration
INFO:teuthology.run_tasks:Running task internal.check_lock...
INFO:teuthology.task.internal:Checking locks...
INFO:teuthology.lock:GET request to 'http://lokesh/lock/lokesh@lokesh'
with body 'None' failed with response code 404
ERROR:teuthology.run_tasks:Saw exception from tasks
Traceback (most recent call last):
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/run_t=
asks.py",
line 25, in run_tasks
    manager =3D _run_one_task(taskname, ctx=3Dctx, config=3Dconfig)
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/run_t=
asks.py",
line 14, in _run_one_task
    return fn(**kwargs)
  File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/task/=
internal.py",
line 110, in check_lock
    'could not read lock status for {name}'.format(name=3Dmachine)
AssertionError: could not read lock status for lokesh@lokesh

i didnt get idea abt it . but the server is working fine.. any idea pls=
 reply.



With Regards,

Lokesh K



On Tue, Oct 2, 2012 at 10:36 PM, Tommi Virtanen <tv@inktank.com> wrote:
> On Tue, Oct 2, 2012 at 9:56 AM, Gregory Farnum <greg@inktank.com> wro=
te:
>>> File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/mis=
c.py",
>>> line 501, in read_config
>>> ctx.teuthology_config.update(new)
>>> ValueError: dictionary update sequence element #0 has length 1; 2 i=
s
>>> required
>> I haven't looked at teuthology much in a while, but the error is
>> complaining that you have a list of length 1 that requires length 2.
>> I'm pretty sure your problem is that you only have one machine
>> available, but the default Ceph task wants 2.
>
> Actually, that error seems to be bubbling up from where it reads
> ~/.teuthology.yaml -- it expects a file like this:
>
> lock_server: http://foo.example.com/locker/lock
> queue_host: bar.example.com
> queue_port: 1234
>
> Teuthology doesn't have much in the way of data format enforcement --
> it kind of assumes the target audience is programmers, so they can
> just dig in.
>
>> Rather more importantly than that, teuthology is a piece of our
>> internal infrastructure. We make it available to others, but if you
>> plan to use it in your own testing you will need infrastructure of
>> your own to run it on =97 we have a generic server farm, but also
>> "special" machines like a lock server, in addition to the client
>> actually running the test. You should not play with it casually.
>
> Hey, I resent that remark!
>
> We *want* outside users for teuthology. That would be awesome.
>
> That would probably also mean needing to split the current "tasks" ou=
t
> of the teuthology core, so that the core becomes a general-purpose
> multi-machine test runner.
>
> But you are correct in that there are a lot of assumptions about the
> environment in there. Tread carefully.



--=20
With Regards,

Lokesh K
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
