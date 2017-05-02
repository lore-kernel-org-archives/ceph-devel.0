From: Dan van der Ster <dan@vanderster.com>
Subject: Re: revisiting uneven CRUSH distributions
Date: Tue, 2 May 2017 12:39:18 +0200
Message-ID: <CABZ+qq=Tfh3VSiX+9FkcrqXn7X6mS6Z2=n4rxyi=1DDaF5bSAg@mail.gmail.com>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
 <CABZ+qqnqiUFbz=6CegW_o=2goOThpmoskDQ0oOUfE27jW0D17A@mail.gmail.com> <03d71363-b865-90af-2d4e-7490e7787caa@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33081 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdEBKkB (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 May 2017 06:40:01 -0400
Received: by mail-io0-f177.google.com with SMTP id o22so22779179iod.0
        for <ceph-devel@vger.kernel.org>; Tue, 02 May 2017 03:40:01 -0700 (PDT)
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com. [209.85.223.182])
        by smtp.gmail.com with ESMTPSA id y22sm7626144ioi.26.2017.05.02.03.40.00
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 May 2017 03:40:00 -0700 (PDT)
Received: by mail-io0-f182.google.com with SMTP id r16so154342786ioi.2
        for <ceph-devel@vger.kernel.org>; Tue, 02 May 2017 03:40:00 -0700 (PDT)
In-Reply-To: <03d71363-b865-90af-2d4e-7490e7787caa@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, May 2, 2017 at 12:21 PM, Loic Dachary <loic@dachary.org> wrote:
> On 05/02/2017 11:35 AM, Dan van der Ster wrote:
> > Hi Loic,
> >
> > I'm not managing to compile this on my CentOS 7 dev box.
>
> What error do you get ? With pip 8.1 + you should not need to compile, th=
ere are binary wheels available.
>

Double requirement given: appdirs=3D=3D1.4.3 (from -r
/root/git/python-crush/requirements-dev.txt (line 8)) (already in
appdirs=3D=3D1.4.3 (from -r /root/git/python-crush/requirements.txt (line
10)), name=3D'appdirs')

[root@dvanders-work python-crush]# grep appdirs *.txt
requirements-dev.txt:appdirs=3D=3D1.4.3
requirements.txt:appdirs=3D=3D1.4.3



> > Do you want to try a "complicated" crush map? Here is ours: https://www=
.dropbox.com/s/ihg7cwz7wug50pb/cern.crush?dl=3D1
>
> Could you also tell me the pool numbers, pg_num and size and the rule the=
y use ?

pool 4 'volumes' replicated size 3 min_size 2 crush_ruleset 0
object_hash rjenkins pg_num 4096 pgp_num 4096 last_change 628176 flags
nodelete,nopgchange,nosizechange min_read_recency_for_promote 1
stripe_width 0
pool 5 'images' replicated size 3 min_size 2 crush_ruleset 0
object_hash rjenkins pg_num 2048 pgp_num 2048 last_change 628178 flags
hashpspool,nodelete,nopgchange,nosizechange
min_read_recency_for_promote 1 stripe_width 0
pool 75 'cinder-critical' replicated size 3 min_size 2 crush_ruleset 4
object_hash rjenkins pg_num 8192 pgp_num 8192 last_change 587162 flags
hashpspool,nodelete,nopgchange,nosizechange
min_read_recency_for_promote 1 stripe_width 0


>
> > The important rules are "data" and "critical", and note that there are =
two rooms which are expected to fill at different rates. So we'd like to op=
timize separately for buckets 0513-R-0050 and 0513-R-0060.
>
> Thanks, I will :-)
>

Cool, thanks!

-- Dan

> > Cheers, Dan
> >
> >
> > On Sun, Apr 30, 2017 at 4:15 PM, Loic Dachary <loic@dachary.org <mailto=
:loic@dachary.org>> wrote:
> >
> >     Hi,
> >
> >     Ideally CRUSH distributes PGs evenly on OSDs so that they all fill =
in
> >     the same proportion. If an OSD is 75% full, it is expected that all
> >     other OSDs are also 75% full.
> >
> >     In reality the distribution is even only when more than 100,000 PGs
> >     are distributed in a pool of size 1 (i.e. no replication).
> >
> >     In small clusters there are a few thousands PGs and it is not enoug=
h
> >     to get an even distribution. Running the following with
> >     python-crush[1], shows a 15% difference when distributing 1,000 PGs=
 on
> >     6 devices. Only with 1,000,000 PGs does the difference drop under 1=
%.
> >
> >       for PGs in 1000 10000 100000 1000000 ; do
> >         crush analyze --replication-count 1 \
> >                       --type device \
> >                       --values-count $PGs \
> >                       --rule data \
> >                       --crushmap tests/sample-crushmap.json
> >       done
> >
> >     In larger clusters, even though a greater number of PGs are
> >     distributed, there are at most a few dozens devices per host and th=
e
> >     problem remains. On a machine with 24 OSDs each expected to handle =
a
> >     few hundred PGs, a total of a few thousands PGs are distributed whi=
ch
> >     is not enough to get an even distribution.
> >
> >     There is a secondary reason for the distribution to be uneven, when
> >     there is more than one replica. The second replica must be on a
> >     different device than the first replica. This conditional probabili=
ty
> >     is not taken into account by CRUSH and would create an uneven
> >     distribution if more than 10,000 PGs were distributed per OSD[2]. B=
ut
> >     a given OSD can only handle a few hundred PGs and this conditional
> >     probability bias is dominated by the uneven distribution caused by =
the
> >     low number of PGs.
> >
> >     The uneven CRUSH distributions are always caused by a low number of
> >     samples, even in large clusters. Since this noise (i.e. the differe=
nce
> >     between the desired distribution and the actual distribution) is
> >     random, it cannot be fixed by optimizations methods.  The
> >     Nedler-Mead[3] simplex converges to a local minimum that is far fro=
m
> >     the optimal minimum in many cases. Broyden=E2=80=93Fletcher=E2=80=
=93Goldfarb=E2=80=93Shanno[4]
> >     fails to find a gradient that would allow it to converge faster. An=
d
> >     even if it did, the local minimum found would be as often wrong as
> >     with Nedler-Mead, only it would go faster. A least mean squares
> >     filter[5] is equally unable to suppress the noise created by the
> >     uneven distribution because no coefficients can model a random nois=
e.
> >
> >     With that in mind, I implemented a simple optimization algorithm[6]
> >     which was first suggested by Thierry Delamare a few weeks ago. It g=
oes
> >     like this:
> >
> >         - Distribute the desired number of PGs[7]
> >         - Subtract 1% of the weight of the OSD that is the most over us=
ed
> >         - Add the subtracted weight to the OSD that is the most under u=
sed
> >         - Repeat until the Kullback=E2=80=93Leibler divergence[8] is sm=
all enough
> >
> >     Quoting Adam Kupczyk, this works because:
> >
> >       "...CRUSH is not random proces at all, it behaves in numerically
> >        stable way.  Specifically, if we increase weight on one node, we
> >        will get more PGs on this node and less on every other node:
> >        CRUSH([10.1, 10, 10, 5, 5]) -> [146(+3), 152, 156(-2), 70(-1), 7=
6]"
> >
> >     A nice side effect of this optimization algorithm is that it does n=
ot
> >     change the weight of the bucket containing the items being
> >     optimized. It is local to a bucket with no influence on the other
> >     parts of the crushmap (modulo the conditional probability bias).
> >
> >     In all tests the situation improves at least by an order of
> >     magnitude. For instance when there is a 30% difference between two
> >     OSDs, it is down to less than 3% after optimization.
> >
> >     The tests for the optimization method can be run with
> >
> >        git clone -b wip-fix-2 http://libcrush.org/dachary/python-crush.=
git <http://libcrush.org/dachary/python-crush.git>
> >        tox -e py27 -- -s -vv -k test_fix tests/test_analyze.py
> >
> >     If anyone think of a reason why this algorithm won't work in some
> >     cases, please speak up :-)
> >
> >     Cheers
> >
> >     [1] python-crush http://crush.readthedocs.io/
> >     [2] crush multipick anomaly http://marc.info/?l=3Dceph-devel&m=3D14=
8539995928656&w=3D2 <http://marc.info/?l=3Dceph-devel&m=3D148539995928656&w=
=3D2>
> >     [3] Nedler-Mead https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead_m=
ethod <https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead_method>
> >     [4] L-BFGS-B https://docs.scipy.org/doc/scipy-0.18.1/reference/opti=
mize.minimize-lbfgsb.html#optimize-minimize-lbfgsb <https://docs.scipy.org/=
doc/scipy-0.18.1/reference/optimize.minimize-lbfgsb.html#optimize-minimize-=
lbfgsb>
> >     [5] Least mean squares filter https://en.wikipedia.org/wiki/Least_m=
ean_squares_filter <https://en.wikipedia.org/wiki/Least_mean_squares_filter=
>
> >     [6] http://libcrush.org/dachary/python-crush/blob/c6af9bbcbef7123af=
84ee4d75d63dd1b967213a2/tests/test_analyze.py#L39 <http://libcrush.org/dach=
ary/python-crush/blob/c6af9bbcbef7123af84ee4d75d63dd1b967213a2/tests/test_a=
nalyze.py#L39>
> >     [7] Predicting Ceph PG placement http://dachary.org/?p=3D4020
> >     [8] Kullback=E2=80=93Leibler divergence https://en.wikipedia.org/wi=
ki/Kullback%E2%80%93Leibler_divergence <https://en.wikipedia.org/wiki/Kullb=
ack%E2%80%93Leibler_divergence>
> >
> >     --
> >     Lo=C3=AFc Dachary, Artisan Logiciel Libre
> >     --
> >     To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> >     the body of a message to majordomo@vger.kernel.org <mailto:majordom=
o@vger.kernel.org>
> >     More majordomo info at  http://vger.kernel.org/majordomo-info.html =
<http://vger.kernel.org/majordomo-info.html>
> >
> >
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
