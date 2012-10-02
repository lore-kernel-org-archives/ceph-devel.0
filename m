From: Gregory Farnum <greg@inktank.com>
Subject: Re: [ceph-commit] teuthology value error
Date: Tue, 2 Oct 2012 09:56:13 -0700
Message-ID: <CAPYLRzice5K7H1W6baizm0EK=J9nAZX4Hm5FcVETB8_ikyDp4Q@mail.gmail.com>
References: <CABpo6hJZPKt1p1g4yC+KviC4Wr6OKuffcNGyVL9UeoJe8K+TDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:39665 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147Ab2JBQ4N convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 12:56:13 -0400
Received: by iagy32 with SMTP id y32so763369iag.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 09:56:13 -0700 (PDT)
In-Reply-To: <CABpo6hJZPKt1p1g4yC+KviC4Wr6OKuffcNGyVL9UeoJe8K+TDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Lokesh Krishnappa <lokesh.professional.it@gmail.com>
Cc: ceph-devel@vger.kernel.org

[Moving to ceph-devel list, which is a better fit than ceph-commit.]

On Tue, Oct 2, 2012 at 3:33 AM, Lokesh Krishnappa
<lokesh.professional.it@gmail.com> wrote:
> Hi all,
> Am new to ceph test suite. trying to execute test command in single m=
achine
> , test bed setup as follows:
> teuthology: 0.0.1
> os: ubuntu12.04LTS
> config file format: (rbd_cls_tests1.yaml)
>
> roles:
>
> [mon.a,osd.0,osd.1]
>
> targets:
> lokesh@lokesh: ssh-rsa
> AAAAB3NzaC1yc2EAAAADAQABAAABAQDmSb/VpYpdSQLp4unsKUNV/DKV2f55M1QSXHu10=
Qvco33rYopOF/l5+eYlINCHF1v/SA+bLOMT/4OHGkZR67TajAoXFpyolVSxZKRoJHLV2iJ+=
MrRiaxShctMYWpLOjc4iRA4BG3FTG5TTPKJweDj8dDdUIqZ9PuSpP5VuOriCpQkPWECL2hJ=
qAYwnknK1Uhg3rYV0XxL14Iep9KCZf2PcJNw3Eur6XKDAczu/sAUlOiLrBsQpFmOaPY5jFD=
aM3U7KpJvqiI4Drq331iMh9n3GuA+JvcTMKuT7CN36GswlvGuakTzaDoR66JaYYKkGzDl97=
7K94XrAdQwa2NKLu1XH
>
> tasks:
>
> ceph:
> ceph-fuse:
> workunit: clients: client.0: - rbd/test_cls_rbd.sh -interactive-on-er=
ror:
> true
>
> While executing the above config file, using:
> lokesh@lokesh:~/Downloads/ceph-teuthology-78b7b02$
> ./virtualenv/bin/teuthology rbd_cls_tests1.yaml
>
> had getting error msg as:
>
>
> Traceback (most recent call last):
> File "./virtualenv/bin/teuthology", line 9, in
> load_entry_point('teuthology=3D=3D0.0.1', 'console_scripts', 'teuthol=
ogy')()
> File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/run.p=
y",
> line 97, in main
> read_config(ctx)
> File "/home/lokesh/Downloads/ceph-teuthology-78b7b02/teuthology/misc.=
py",
> line 501, in read_config
> ctx.teuthology_config.update(new)
> ValueError: dictionary update sequence element #0 has length 1; 2 is
> required
>
> I dint get clear picture abt the error . so could any one help me out=
 .

I haven't looked at teuthology much in a while, but the error is
complaining that you have a list of length 1 that requires length 2.
I'm pretty sure your problem is that you only have one machine
available, but the default Ceph task wants 2.

Rather more importantly than that, teuthology is a piece of our
internal infrastructure. We make it available to others, but if you
plan to use it in your own testing you will need infrastructure of
your own to run it on =97 we have a generic server farm, but also
"special" machines like a lock server, in addition to the client
actually running the test. You should not play with it casually.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
