From: han vincent <hangzws@gmail.com>
Subject: Fwd: Beta testing crush optimization
Date: Thu, 1 Jun 2017 14:29:39 +0800
Message-ID: <CANNfkua2F6=tk8tRoE_3GB6VyszsPur9Q9=38LT_fkZ+-kBiSQ@mail.gmail.com>
References: <CANNfkubYdJqJDRV8kuNDBy368OxOyXkXKU3wr9ULFeafPnBoHg@mail.gmail.com>
 <b5814b74-fb97-85de-3f8b-f906c5363195@dachary.org> <d3cee009-9187-d90a-4a40-6ab98e619897@dachary.org>
 <CANNfkubv6FF_5NHBr6reE-Tq7Tfy8Yqg2TX=xiCO06qxHFpgrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:33982 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750848AbdFAG3l (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jun 2017 02:29:41 -0400
Received: by mail-it0-f50.google.com with SMTP id a10so503488itg.1
        for <ceph-devel@vger.kernel.org>; Wed, 31 May 2017 23:29:40 -0700 (PDT)
In-Reply-To: <CANNfkubv6FF_5NHBr6reE-Tq7Tfy8Yqg2TX=xiCO06qxHFpgrw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <loic@dachary.org>

---------- Forwarded message ----------
From: han vincent <hangzws@gmail.com>
Date: 2017-06-01 14:27 GMT+08:00
Subject: Re: Beta testing crush optimization
To: Loic Dachary <loic@dachary.org>


Hi, Loic:
  Thanks for you apply,  If you fix the bug, please tell me, thanks.
And I still have some questions troubled me.

  you said there was a "statble" tunable was implemented after hammer,
Does it mean that the version of the "straw2" is unstable in hammer?
  do you know which version the "statble" tunable was pulished?

  >crush optimize --crushmap /tmp/han-vincent-report.json --out-path
/tmp/han-vincent-report-optimized.txt --out-format txt --pool 49
  Is "--pool" options must specified in this command? if not, will it
optimize all the pools without "--pool" option?
  if there are several pools in my cluster and each pool has a lot of
pgs. If I optimize one of the, will it affect the other pools?
  how to use it to optimize multiple pools in a cluster of hammer?

  >(virtualenv) loic@fold:~/software/libcrush/python-crush$ crush
analyze --crushmap /tmp/han-vincent-report-optimized.txt --pool 49
--replication-count=3D2 --pg-num=3D1024 --pgp-num=3D1024
--rule=3Dreplicated_ruleset --choose-args=3D49
  In this command, the value of the "--choose-args" option is 49, it
is same as the pool id, what is the mean of "--choose-args" option?

>2017-05-31 20:40 GMT+08:00 Loic Dachary <loic@dachary.org>:
>
> Hi,
>
> I found the reason for the map problem, thanks a lot for reporting it. In=
 a nutshell the "stable" tunable was implemented after hammer and your ceph=
 report does not mention it at all. python-crush incorrectly assumes this m=
eans it should default to 1. It must default to 0 instead. When I do that m=
anually, all mappings are correct. I'll fix this and publish a new version =
by tomorrow.
>
> Your cluster is not very unbalanced (less than 10% overfilled):
>
> (virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --=
crushmap /tmp/han-vincent-report.json --pool 49
>          ~id~  ~weight~  ~PGs~  ~over/under filled %~
> ~name~
> node-6v    -4      1.08    427                   4.25
> node-4     -2      1.08    416                   1.56
> node-7v    -5      1.08    407                  -0.63
> node-8v    -6      1.08    405                  -1.12
> node-5v    -3      1.08    393                  -4.05
>
> Worst case scenario if a host fails:
>
>         ~over filled %~
> ~type~
> device             7.81
> host               4.10
> root               0.00
> (virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --=
type device --crushmap /tmp/han-vincent-report.json --pool 49
>         ~id~  ~weight~  ~PGs~  ~over/under filled %~
> ~name~
> osd.5      5      0.54    221                   7.91
> osd.0      0      0.54    211                   3.03
> osd.7      7      0.54    210                   2.54
> osd.4      4      0.54    206                   0.59
> osd.8      8      0.54    206                   0.59
> osd.1      1      0.54    205                   0.10
> osd.3      3      0.54    200                  -2.34
> osd.9      9      0.54    199                  -2.83
> osd.6      6      0.54    197                  -3.81
> osd.2      2      0.54    193                  -5.76
>
> Worst case scenario if a host fails:
>
>         ~over filled %~
> ~type~
> device             7.81
> host               4.10
> root               0.00
>
> With optimization things will improve:
>
> $ crush optimize --crushmap /tmp/han-vincent-report.json --out-path /tmp/=
han-vincent-report-optimized.txt --out-format txt --pool 49
> 2017-05-31 15:17:59,917 argv =3D optimize --crushmap /tmp/han-vincent-rep=
ort.json --out-path /tmp/han-vincent-report-optimized.txt --out-format txt =
--pool 49 --replication-count=3D2 --pg-num=3D1024 --pgp-num=3D1024 --rule=
=3Dreplicated_ruleset --out-version=3Dh --no-positions --choose-args=3D49
> 2017-05-31 15:17:59,940 default optimizing
> 2017-05-31 15:18:05,007 default wants to swap 43 PGs
> 2017-05-31 15:18:05,013 node-6v optimizing
> 2017-05-31 15:18:05,013 node-4 optimizing
> 2017-05-31 15:18:05,016 node-8v optimizing
> 2017-05-31 15:18:05,016 node-7v optimizing
> 2017-05-31 15:18:05,018 node-5v optimizing
> 2017-05-31 15:18:05,369 node-4 wants to swap 8 PGs
> 2017-05-31 15:18:05,742 node-6v wants to swap 10 PGs
> 2017-05-31 15:18:06,382 node-5v wants to swap 7 PGs
> 2017-05-31 15:18:06,602 node-7v wants to swap 7 PGs
> 2017-05-31 15:18:07,346 node-8v already optimized
>
> (virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --=
crushmap /tmp/han-vincent-report-optimized.txt --pool 49 --replication-coun=
t=3D2 --pg-num=3D1024 --pgp-num=3D1024 --rule=3Dreplicated_ruleset --choose=
-args=3D49
>          ~id~  ~weight~  ~PGs~  ~over/under filled %~
> ~name~
> node-4     -2      1.08    410                   0.10
> node-5v    -3      1.08    410                   0.10
> node-6v    -4      1.08    410                   0.10
> node-7v    -5      1.08    409                  -0.15
> node-8v    -6      1.08    409                  -0.15
>
> Worst case scenario if a host fails:
>
>         ~over filled %~
> ~type~
> device             5.47
> host               3.71
> root               0.00
> (virtualenv) loic@fold:~/software/libcrush/python-crush$ crush analyze --=
type device --crushmap /tmp/han-vincent-report-optimized.txt --pool 49 --re=
plication-count=3D2 --pg-num=3D1024 --pgp-num=3D1024 --rule=3Dreplicated_ru=
leset --choose-args=3D49
>         ~id~  ~weight~  ~PGs~  ~over/under filled %~
> ~name~
> osd.2      2      0.54    206                   0.59
> osd.8      8      0.54    206                   0.59
> osd.0      0      0.54    205                   0.10
> osd.1      1      0.54    205                   0.10
> osd.4      4      0.54    205                   0.10
> osd.5      5      0.54    205                   0.10
> osd.7      7      0.54    205                   0.10
> osd.3      3      0.54    204                  -0.39
> osd.6      6      0.54    204                  -0.39
> osd.9      9      0.54    203                  -0.88
>
> Worst case scenario if a host fails:
>
>         ~over filled %~
> ~type~
> device             5.47
>
> host               3.71
> root               0.00
>
> Note that the other pools won't be optimized and their PGs will be moved =
around for no good reason. However, since they contain very few PGs each (8=
 for most of them, 32 for one of them) and very little data (less than 1MB =
total), it won't matter much.
>
> Cheers
>
> On 05/31/2017 02:34 PM, Loic Dachary wrote:
> > Hi,
> >
> > On 05/31/2017 12:32 PM, han vincent wrote:
> >> hello, loic:
> >>
> >> I had a cluster build with hammer 0.94.10, then I used the following c=
ommands to change the algorithm from "straw" to "straw2".
> >> 1. ceph osd crush tunables hammer
> >> 2. ceph osd getcrushmap -o /tmp/cmap
> >> 3. crushtool -d /tmp/cmap -o /tmp/cmap.txt
> >> 4. vim /tmp/cmap.txt and change the algorithm of each bucket from "str=
aw" to "straw2"
> >> 5. crushtool -c /tmp/cmap.txt -o /tmp/cmap
> >> 6. ceph osd setcrushmap -i /tmp/cmap
> >> 7. ceph osd crush reweight-all
> >> after that, I used "python crush" to optimize the cluster, the version=
 of "python crush" is 1.0.32
> >>
> >> 1. ceph report > report.json
> >> 2. crush optimize --crushmap report.json --out-path optimized.crush
> >> Unfortunately, there was an error in the output:
> >>
> >> 2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]
> >> 2017-05-30 18:48:01,838 49.3af map to [9, 2] instead of [9, 3]
> >> 2017-05-30 18:48:01,838 49.e3 map to [6, 4] instead of [6, 5]
> >> 2017-05-30 18:48:01,838 49.e1 map to [7, 2] instead of [7, 3]
> >> 2017-05-30 18:48:01,838 49.e0 map to [5, 1] instead of [5, 0]
> >> 2017-05-30 18:48:01,838 49.20d map to [3, 1] instead of [3, 0]
> >> 2017-05-30 18:48:01,838 49.20c map to [2, 9] instead of [2, 8]
> >> 2017-05-30 18:48:01,838 49.36e map to [6, 1] instead of [6, 0]
> >> ......
> >>
> >> Traceback (most recent call last):
> >>  File "/usr/bin/crush", line 25, in <module>
> >> sys.exit(Ceph().main(sys.argv[1:]))
> >>  File "/usr/lib64/python2.7/site-packages/crush/main.py", line 136, in=
 main
> >> return self.constructor(argv).run()
> >>  File "/usr/lib64/python2.7/site-packages/crush/optimize.py", line 373=
, in run
> >> crushmap =3D self.main.convert_to_crushmap(self.args.crushmap)
> >>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", lin=
e 690, in convert_to_crushmap
> >> c.parse(crushmap)
> >>  File "/usr/lib64/python2.7/site-packages/crush/__init__.py", line 138=
, in parse
> >> return self.parse_crushmap(self._convert_to_crushmap(something))
> >>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", lin=
e 416, in _convert_to_crushmap
> >> crushmap =3D CephReport().parse_report(something)
> >>  File "/usr/lib64/python2.7/site-packages/crush/ceph/__init__.py", lin=
e 137, in parse_report
> >> raise MappingError("some mapping failed, please file a bug at "
> >> crush.ceph.MappingError: some mapping failed, please file a bug at htt=
p://libcrush.org/main/python-crush/issues/new
> >> Do you know what the problem is? can you help me? I would be very grat=
eful to you.
> >
> > This is a safeguard to make sure python-crush maps exactly as expected.=
 I'm not sure yet why there is a difference but I'll work on that, using th=
e crush implementation found in hammer 0.94.10. For your information, the f=
ull output of:
> >
> > $ crush analyze --crushmap /tmp/han-vincent-report.json
> >
> > is at https://paste2.org/PyeHe2dC What I find strange is that your outp=
ut regarding pool 42 is different than mine. You have:
> >
> >
> > 2017-05-30 18:48:01,803 42.1 map to [4, 9] instead of [4, 8]
> >
> > and I have
> >
> > 2017-05-31 12:55:04,207 42.3 map to [4, 3] instead of [4, 2]
> > 2017-05-31 12:55:04,207 42.7 map to [8, 0] instead of [8, 1]
> > 2017-05-31 12:55:04,207 42.1 map to [4, 9] instead of [4, 8]
> >
> > I wonder if that's a sign that the changes to the crushmap following yo=
ur change to straw2 are still going on. Would you mind sending me the outpu=
t of ceph report (please run it again after receiving this mail) ?
> >
> > Cheers
> >
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
