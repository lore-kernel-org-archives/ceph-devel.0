From: Spandan Kumar Sahu <spandankumarsahu@gmail.com>
Subject: Re: revisiting uneven CRUSH distributions
Date: Mon, 8 May 2017 15:29:39 +0530
Message-ID: <CAAXqJ+p7peHL+kEe+-+CJO3=sRmYPV=6oZmXf2t_-8s1q9jbkA@mail.gmail.com>
References: <712e34ca-d94e-b4a5-6195-5ca4cbc2aa34@dachary.org>
 <CABZ+qqnqiUFbz=6CegW_o=2goOThpmoskDQ0oOUfE27jW0D17A@mail.gmail.com>
 <03d71363-b865-90af-2d4e-7490e7787caa@dachary.org> <CABZ+qq=Tfh3VSiX+9FkcrqXn7X6mS6Z2=n4rxyi=1DDaF5bSAg@mail.gmail.com>
 <863c7a23-b302-bfbc-ed58-202f981bf5fa@dachary.org> <CAAXqJ+qd_pj-1KMGwKVBc+7egAxJ01fKs5EHbypV=_R6R8BEtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f51.google.com ([209.85.218.51]:36659 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbdEHJ7k (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 May 2017 05:59:40 -0400
Received: by mail-oi0-f51.google.com with SMTP id h4so44394720oib.3
        for <ceph-devel@vger.kernel.org>; Mon, 08 May 2017 02:59:40 -0700 (PDT)
In-Reply-To: <CAAXqJ+qd_pj-1KMGwKVBc+7egAxJ01fKs5EHbypV=_R6R8BEtw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Dan van der Ster <dan@vanderster.com>, Ceph Development <ceph-devel@vger.kernel.org>

I am sorry for hijacking the thread. I was unaware of it, until my
mentor pointed this out.

So I will write in, my observations regarding the current algorithm.

* Subtracting 1% from the most over-used and adding it to the
least-used one doesn't change the weights of the other OSDs. So, the
time taken to achieve the required distribution will be more. Instead,
I suggest to, for each OSD, calculate the difference between the
desired percentage used and its current percentage used, multiply with
a constant and that to the existing weights. In this way, at each
iteration, the weight of each OSD changes towards the desired weight
distribution. Hence it will be faster.

* Also, we need to consider the weights of the OSDs while making a
change. For example, a 1% over-use in a highly weighted device, might
mean, more data is unevenly distributed ( since, the OSDs weights are
in general a measure of their storing capacity). So, all the changes
that we make to the weights of the OSDs, we need to scale or factor
according to the weight of the OSD.

* The case when there are multiple OSDs are most over-used and
multiple OSDs are most-underused, has not been handled. If I make
reasonable assumptions, then, the weight of the most-underused
increase by the same factor, thereby, introducing a possibility of
uneven distribution.

* The noises, as explained, are random. So, in order to cancel them,
we don't just need to add or subtract the current difference between
the desired and current weight percentage, but also take care of
noises in the past. This can be done by introducing another, factor
called "integral-factor" and "derivative-factor".
There are algorithms to handle noises. One of such algorithm is
"PID-based" feedback mechanism. The current implementation is a weak
form of PID-based feedback. I have explained a modified one with an
example here[1].

Thanks

Spandan Kumar Sahu

[1] : https://github.com/SpandanKumarSahu/Ceph_Proposal/blob/master/Readme

On Mon, May 8, 2017 at 9:04 AM, Spandan Kumar Sahu
<spandankumarsahu@gmail.com> wrote:
> Hello
>
> I have been selected under Google Summer of Code program to work under
> the "Smarter Reweight by Utilisation" project, and I believe this is
> very similar to what Loic is working on.
>
> I would really appreciate if anyone can go through the proposed
> solution, and give feedback. In short, it is somewhat similar, to
> Loic's initial proposal. In more general terms, instead of simply
> subtracting and adding 1% from the most and least used OSDs, it tries
> to distribute the difference between the set value and the actual
> value, among all the OSDs, in proportion to their weights. It uses
> some other tricks, which I have explained over here [1] and just the
> algorithm part over here [2].
>
> In [1] I have also given justification as to why this will work more
> efficiently.
>
> [1] : https://docs.google.com/document/d/1RFvHEJiSXtTTjEX0MDWfaRkWwYjnQfV=
18EuXGsw2hm0/edit?usp=3Dsharing
> [2] : https://github.com/SpandanKumarSahu/Ceph_Proposal
>
> --
> Spandan Kumar Sahu
> IIT Kharagpur
>
> On Sat, May 6, 2017 at 6:51 PM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Dan,
>>
>> The optimization works for pool 5 which is using the "data" rule. It's a=
n extreme case because there are very few PG per OSD (about 6) and, as expe=
cted, very uneven and some of them even have no PG at all (the list is abre=
viated but you can find it in full at https://paste2.org/3j1hbd3d):
>>
>>           ~id~  ~weight~      ~PGs~  ~over/under used %~
>> ~name~
>> osd.104    104  5.459991         17           124.674479
>> osd.704    704  5.459991         16           111.458333
>> osd.75      75  5.459991         16           111.458333
>> ...
>> osd.25      25  5.459991          2           -73.567708
>> osd.336    336  5.459991          1           -86.783854
>> osd.673    673  5.459991          1           -86.783854
>> osd.496    496  5.459991          0          -100.000000
>> osd.646    646  5.459991          0          -100.000000
>>
>> The failure domain (rack) only has ~5% over / under full racks. But, thi=
s has an impact on the uneven distribution within each rack.
>>
>>         ~id~    ~weight~      ~PGs~  ~over/under used %~
>> ~name~
>> RA13      -9  786.238770       1150             5.545609
>> RA01     -72  911.818573       1270             0.506019
>> RA09      -6  917.278564       1274             0.222439
>> RA17     -14  900.898590       1238            -0.838857
>> RA05      -4  917.278564       1212            -4.654948
>>
>> After optimization the distribution of the OSDs is still uneven, even th=
ough it improved significantly:
>>
>>           ~id~  ~weight~      ~PGs~  ~over/under used %~
>> ~name~
>> osd.252    252  5.459991         10            32.161458
>> osd.330    330  5.459991         10            32.161458
>> osd.571    571  5.459991          9            18.945312
>> ...
>> osd.261    261  5.459991          5           -33.919271
>> osd.210    210  5.459991          5           -33.919271
>> osd.1269  1269  5.459991          4           -47.135417
>>
>> and the racks uneven distribution dropped under 0.5% which is better:
>>
>>         ~id~    ~weight~      ~PGs~  ~over/under used %~
>> ~name~
>> RA17     -14  900.898590       1252             0.282513
>> RA01     -72  911.818573       1267             0.268603
>> RA13      -9  786.238770       1089            -0.052897
>> RA05      -4  917.278564       1269            -0.170898
>> RA09      -6  917.278564       1267            -0.328234
>>
>> I'll keep working on optimizing the two other pools. Don't hesistate to =
tell me if I'm going in the wrong direction.
>>
>> Cheers
>>
>>
>> On 05/02/2017 12:39 PM, Dan van der Ster wrote:
>>> On Tue, May 2, 2017 at 12:21 PM, Loic Dachary <loic@dachary.org> wrote:
>>>> On 05/02/2017 11:35 AM, Dan van der Ster wrote:
>>>>> Hi Loic,
>>>>>
>>>>> I'm not managing to compile this on my CentOS 7 dev box.
>>>>
>>>> What error do you get ? With pip 8.1 + you should not need to compile,=
 there are binary wheels available.
>>>>
>>>
>>> Double requirement given: appdirs=3D=3D1.4.3 (from -r
>>> /root/git/python-crush/requirements-dev.txt (line 8)) (already in
>>> appdirs=3D=3D1.4.3 (from -r /root/git/python-crush/requirements.txt (li=
ne
>>> 10)), name=3D'appdirs')
>>>
>>> [root@dvanders-work python-crush]# grep appdirs *.txt
>>> requirements-dev.txt:appdirs=3D=3D1.4.3
>>> requirements.txt:appdirs=3D=3D1.4.3
>>>
>>>
>>>
>>>>> Do you want to try a "complicated" crush map? Here is ours: https://w=
ww.dropbox.com/s/ihg7cwz7wug50pb/cern.crush?dl=3D1
>>>>
>>>> Could you also tell me the pool numbers, pg_num and size and the rule =
they use ?
>>>
>>> pool 4 'volumes' replicated size 3 min_size 2 crush_ruleset 0
>>> object_hash rjenkins pg_num 4096 pgp_num 4096 last_change 628176 flags
>>> nodelete,nopgchange,nosizechange min_read_recency_for_promote 1
>>> stripe_width 0
>>> pool 5 'images' replicated size 3 min_size 2 crush_ruleset 0
>>> object_hash rjenkins pg_num 2048 pgp_num 2048 last_change 628178 flags
>>> hashpspool,nodelete,nopgchange,nosizechange
>>> min_read_recency_for_promote 1 stripe_width 0
>>> pool 75 'cinder-critical' replicated size 3 min_size 2 crush_ruleset 4
>>> object_hash rjenkins pg_num 8192 pgp_num 8192 last_change 587162 flags
>>> hashpspool,nodelete,nopgchange,nosizechange
>>> min_read_recency_for_promote 1 stripe_width 0
>>>
>>>
>>>>
>>>>> The important rules are "data" and "critical", and note that there ar=
e two rooms which are expected to fill at different rates. So we'd like to =
optimize separately for buckets 0513-R-0050 and 0513-R-0060.
>>>>
>>>> Thanks, I will :-)
>>>>
>>>
>>> Cool, thanks!
>>>
>>> -- Dan
>>>
>>>>> Cheers, Dan
>>>>>
>>>>>
>>>>> On Sun, Apr 30, 2017 at 4:15 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>>>>
>>>>>     Hi,
>>>>>
>>>>>     Ideally CRUSH distributes PGs evenly on OSDs so that they all fil=
l in
>>>>>     the same proportion. If an OSD is 75% full, it is expected that a=
ll
>>>>>     other OSDs are also 75% full.
>>>>>
>>>>>     In reality the distribution is even only when more than 100,000 P=
Gs
>>>>>     are distributed in a pool of size 1 (i.e. no replication).
>>>>>
>>>>>     In small clusters there are a few thousands PGs and it is not eno=
ugh
>>>>>     to get an even distribution. Running the following with
>>>>>     python-crush[1], shows a 15% difference when distributing 1,000 P=
Gs on
>>>>>     6 devices. Only with 1,000,000 PGs does the difference drop under=
 1%.
>>>>>
>>>>>       for PGs in 1000 10000 100000 1000000 ; do
>>>>>         crush analyze --replication-count 1 \
>>>>>                       --type device \
>>>>>                       --values-count $PGs \
>>>>>                       --rule data \
>>>>>                       --crushmap tests/sample-crushmap.json
>>>>>       done
>>>>>
>>>>>     In larger clusters, even though a greater number of PGs are
>>>>>     distributed, there are at most a few dozens devices per host and =
the
>>>>>     problem remains. On a machine with 24 OSDs each expected to handl=
e a
>>>>>     few hundred PGs, a total of a few thousands PGs are distributed w=
hich
>>>>>     is not enough to get an even distribution.
>>>>>
>>>>>     There is a secondary reason for the distribution to be uneven, wh=
en
>>>>>     there is more than one replica. The second replica must be on a
>>>>>     different device than the first replica. This conditional probabi=
lity
>>>>>     is not taken into account by CRUSH and would create an uneven
>>>>>     distribution if more than 10,000 PGs were distributed per OSD[2].=
 But
>>>>>     a given OSD can only handle a few hundred PGs and this conditiona=
l
>>>>>     probability bias is dominated by the uneven distribution caused b=
y the
>>>>>     low number of PGs.
>>>>>
>>>>>     The uneven CRUSH distributions are always caused by a low number =
of
>>>>>     samples, even in large clusters. Since this noise (i.e. the diffe=
rence
>>>>>     between the desired distribution and the actual distribution) is
>>>>>     random, it cannot be fixed by optimizations methods.  The
>>>>>     Nedler-Mead[3] simplex converges to a local minimum that is far f=
rom
>>>>>     the optimal minimum in many cases. Broyden=E2=80=93Fletcher=E2=80=
=93Goldfarb=E2=80=93Shanno[4]
>>>>>     fails to find a gradient that would allow it to converge faster. =
And
>>>>>     even if it did, the local minimum found would be as often wrong a=
s
>>>>>     with Nedler-Mead, only it would go faster. A least mean squares
>>>>>     filter[5] is equally unable to suppress the noise created by the
>>>>>     uneven distribution because no coefficients can model a random no=
ise.
>>>>>
>>>>>     With that in mind, I implemented a simple optimization algorithm[=
6]
>>>>>     which was first suggested by Thierry Delamare a few weeks ago. It=
 goes
>>>>>     like this:
>>>>>
>>>>>         - Distribute the desired number of PGs[7]
>>>>>         - Subtract 1% of the weight of the OSD that is the most over =
used
>>>>>         - Add the subtracted weight to the OSD that is the most under=
 used
>>>>>         - Repeat until the Kullback=E2=80=93Leibler divergence[8] is =
small enough
>>>>>
>>>>>     Quoting Adam Kupczyk, this works because:
>>>>>
>>>>>       "...CRUSH is not random proces at all, it behaves in numericall=
y
>>>>>        stable way.  Specifically, if we increase weight on one node, =
we
>>>>>        will get more PGs on this node and less on every other node:
>>>>>        CRUSH([10.1, 10, 10, 5, 5]) -> [146(+3), 152, 156(-2), 70(-1),=
 76]"
>>>>>
>>>>>     A nice side effect of this optimization algorithm is that it does=
 not
>>>>>     change the weight of the bucket containing the items being
>>>>>     optimized. It is local to a bucket with no influence on the other
>>>>>     parts of the crushmap (modulo the conditional probability bias).
>>>>>
>>>>>     In all tests the situation improves at least by an order of
>>>>>     magnitude. For instance when there is a 30% difference between tw=
o
>>>>>     OSDs, it is down to less than 3% after optimization.
>>>>>
>>>>>     The tests for the optimization method can be run with
>>>>>
>>>>>        git clone -b wip-fix-2 http://libcrush.org/dachary/python-crus=
h.git <http://libcrush.org/dachary/python-crush.git>
>>>>>        tox -e py27 -- -s -vv -k test_fix tests/test_analyze.py
>>>>>
>>>>>     If anyone think of a reason why this algorithm won't work in some
>>>>>     cases, please speak up :-)
>>>>>
>>>>>     Cheers
>>>>>
>>>>>     [1] python-crush http://crush.readthedocs.io/
>>>>>     [2] crush multipick anomaly http://marc.info/?l=3Dceph-devel&m=3D=
148539995928656&w=3D2 <http://marc.info/?l=3Dceph-devel&m=3D148539995928656=
&w=3D2>
>>>>>     [3] Nedler-Mead https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead=
_method <https://en.wikipedia.org/wiki/Nelder%E2%80%93Mead_method>
>>>>>     [4] L-BFGS-B https://docs.scipy.org/doc/scipy-0.18.1/reference/op=
timize.minimize-lbfgsb.html#optimize-minimize-lbfgsb <https://docs.scipy.or=
g/doc/scipy-0.18.1/reference/optimize.minimize-lbfgsb.html#optimize-minimiz=
e-lbfgsb>
>>>>>     [5] Least mean squares filter https://en.wikipedia.org/wiki/Least=
_mean_squares_filter <https://en.wikipedia.org/wiki/Least_mean_squares_filt=
er>
>>>>>     [6] http://libcrush.org/dachary/python-crush/blob/c6af9bbcbef7123=
af84ee4d75d63dd1b967213a2/tests/test_analyze.py#L39 <http://libcrush.org/da=
chary/python-crush/blob/c6af9bbcbef7123af84ee4d75d63dd1b967213a2/tests/test=
_analyze.py#L39>
>>>>>     [7] Predicting Ceph PG placement http://dachary.org/?p=3D4020
>>>>>     [8] Kullback=E2=80=93Leibler divergence https://en.wikipedia.org/=
wiki/Kullback%E2%80%93Leibler_divergence <https://en.wikipedia.org/wiki/Kul=
lback%E2%80%93Leibler_divergence>
>>>>>
>>>>>     --
>>>>>     Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>     --
>>>>>     To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>>     the body of a message to majordomo@vger.kernel.org <mailto:majord=
omo@vger.kernel.org>
>>>>>     More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l <http://vger.kernel.org/majordomo-info.html>
>>>>>
>>>>>
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
> --
> Spandan Kumar Sahu
> IIT Kharagpur



--=20
Spandan Kumar Sahu
IIT Kharagpur
