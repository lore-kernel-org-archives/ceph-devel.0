From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: FW: CURSH optimization for unbalanced pg distribution
Date: Tue, 09 Sep 2014 21:16:36 -0500
Message-ID: <540FB484.6050005@redhat.com>
References: <51FC7A40FB29414D88A121A7FFEF9A4710DC2188@SHSMSX104.ccr.corp.intel.com> <53299E33.5060809@inktank.com> <alpine.DEB.2.00.1403190814520.316@cobra.newdream.net> <51FC7A40FB29414D88A121A7FFEF9A4710DC3018@SHSMSX104.ccr.corp.intel.com> <540F0252.7040609@dachary.org> <51FC7A40FB29414D88A121A7FFEF9A4710F570D6@SHSMSX104.ccr.corp.intel.com> <alpine.DEB.2.00.1409091805530.17200@cobra.newdream.net> <51FC7A40FB29414D88A121A7FFEF9A4710F5D3CF@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:41910 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbaIJCQj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 22:16:39 -0400
Received: by mail-ig0-f181.google.com with SMTP id h15so5621565igd.2
        for <ceph-devel@vger.kernel.org>; Tue, 09 Sep 2014 19:16:39 -0700 (PDT)
In-Reply-To: <51FC7A40FB29414D88A121A7FFEF9A4710F5D3CF@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhang, Jian" <jian.zhang@intel.com>, Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "He, Yujie" <yujie.he@intel.com>

Very interesting!  I will need to sit down and read through the
attachments tomorrow.  Did you find that this method was superior to
simply reweighing the OSDs based on the quality of the distribution
using the Jenkins hash?  Clearly this isn't easy with lots of pools,
though with some fancy crush rule management you might be able to get
around it to a limited extent.

I haven't done any extensive analysis, but I've also wondered if simply
replacing Jenkins with something like City, Murmur3, or Spooky might
improve distribution quality (and especially whether it would improve
distribution quality given small changes in the input).

Really glad you guys are looking into this!

Mark

On 09/09/2014 08:32 PM, Zhang, Jian wrote:
> Thanks.
>=20
> Created a feature here: http://tracker.ceph.com/issues/9410, to inclu=
de all the attachments. .
> http://tracker.ceph.com/attachments/download/1383/adaptive-crush-modi=
fy.patch
> http://tracker.ceph.com/attachments/download/1384/crush_proposals.pdf
> http://tracker.ceph.com/attachments/download/1385/crush_optimization.=
pdf
>=20
>=20
> Hi all,
>      Several months ago we met an issue of read performance issues (1=
7% degradation) when working on ceph object storage performance evaluat=
ion with 10M objects (scaling from 10K objects to 1Million objects) , a=
nd found the root cause is unbalanced pg distribution among all osd dis=
ks, leading to unbalanced data distribution. We did some further invest=
igation then and identified that CRUSH failed to map pgs evenly to each=
 osd. Please refer to the attached pdf (crush_proposals) for details.
>=20
> Key Message:
>      As mentioned in the attached pdf, we described possible optimiza=
tion proposals (http://tracker.ceph.com/attachments/download/1384/crush=
_proposals.pdf) for CRUSH and got some feedback from community (http://=
permalink.gmane.org/gmane.comp.file-systems.ceph.devel/18979 ) . Sage s=
uggested us take the idea of "Change placement strategy only for step o=
f selecting devices from hosts", by adding a new bucket type called "li=
near", and applying a modulo-like hash function to this kind of buckets=
 to achieve balanced distribution. We followed this suggestion and desi=
gned an optimized CRUSH algorithm, with new hash methods and an adaptiv=
e module. Please refer to the Design and Implementation part for detail=
s. We also wrote some POC for it, see the attached patch. And as a resu=
lt, we got more than 10% read performance improvement using the optimiz=
ed CRUSH algorithm.
>=20
> Design and Implementation:
> 1.Problem Identification
> 1.1 Input key (pps) space of CRUSH is not uniform
>      Since PG# on the nested devices of a host is not uniform even if=
 we select the device using simple modulo operation, we decide to chang=
e the algorithm of hashing raw pg to pps.
> 1.2 Algorithm of selecting items from buckets is not uniform
>      After we get uniform input key space, we should make the procedu=
re of selecting devices from host be uniform. Since current CRUSH algor=
ithm uses Jenkins hash based strategies and failed to reach the goal, w=
e decide to add a new bucket type and apply new (modulo based) hash alg=
orithm to make it.
> 2.Design
> 2.1New pps hash algorithm
>      We design the new pps hash algorithm based on the "Congruential =
pseudo-random number generator" (http://comjnl.oxfordjournals.org/conte=
nt/10/1/74.full.pdf) . It defines a bijection between the original sequ=
ence {0, ...,2^N-1} and some permutation of it. In other words, given d=
ifferent keys between 0 and 2^N-1, the generator will produce different=
 integers, but within the same range {0,...,2^N-1}.
>      Assume there are np PGs in a pool, we can regard pgid (0=A1=DCpg=
id<2^n, np=A1=DC2^n<2*np) as the key, and then it will be hashed into a=
 pps value between 0 and 2^n-1. Since PG# in a pool is usually 2^N, the=
 generator just shuffles the original pgid sequence as output in this c=
ase, making the key space consisting of a permutation of {0,...,2^n-1},=
 which achieves the best uniformity. Moreover, poolid can be regarded a=
s a seed in the generator, producing different pps value even with the =
same pgid but different poolid. Therefore, pgid sequences of various po=
ols are mapped into distinct pps sequences, getting rid of PG overlappi=
ng.
> 2.2 New bucket type, Linear
>      We introduce a new bucket type called "linear", and apply a new =
modulo based hash algorithm to it. As the pps values assigned to each h=
ost are a pseudo-random subset of the original permutation and is possi=
bly out of uniformity, in which situation applying modulo operation dir=
ectly on integers in the subset cannot produce balanced distribution am=
ong disks in the host. To decrease deviation of the subset, we apply a =
balance parameter 1/balance_param to the key before conducting the modu=
lo method.
>      For osd failure and recovery, it assumes that items nested in th=
is kind of bucket will not be removed, nor new items are added, same as=
 the UNIFORM bucket. Linear host will not introduce more data movement =
than the uniform bucket.
> 2.3 Adaptive Strategy
>      Since there is no one constant balance parameter applying for al=
l cases that will result in the best PG distribution. We make it an ada=
ptive procedure by adjusting the balance parameter automatically during=
 the preparation for creating a new pool, according to different cluste=
r topology, PG# and replica#, in order to gain a most uniform distribut=
ion.
>      1) Try different balance_param when preparing for a new pool
>      a. Iteratively call CRUSH(map, ruleno, x, balance_param) to get =
corresponding PG distribution with different balance_params
> =A1=A1=A1=A1b. Calculate stdev of PG# among all osds
> =A1=A1  c. Choose the balance_param with the minimal stdev
>   	2) Add a member variable to pool struct pg_pool_t to save the best=
 balance_param value
>      The adaptive procedure can be described as following:
>      Input: cluster map, total PG number m, adaptive retry times n
>      Output: local optimal balance parameter balance_param min_pg_std=
ev =3D MAX; balance_param =3D a; // initial value for trial from 0 to n=
 {
>      for pgid from 0 to m {
>          calculate pps using the new generator in 2.1;
>          for bucket b in cluster map // apply CRUSH algorithm
>              apply corresponding bucket hashing algorithm and get a o=
sd list for pgid
>      }
>      calculate pg_stdev_a by gathering all osd lists; // stdev of PG =
distribution among all osds
>      if pg_stdev_a < min_pg_stdev {
>          min_pg_stdev =3D pg_stdev_a;
>          balance_param =3D a;
>      }
>      adjust a to a new value;
> }
>=20
>=20
> Evaluation:
>      We evaluated the performance of optimized and current CRUSH in a=
 cluster consisting of 4 hosts, and each attaching with 10x1T disks. We=
 designed two test cases, for the first one, by creating a pool with 20=
48 pgs, 2 replicas, preparing 100 million 128KB objects, and then evalu=
ating read performance of these objects; for the second one, by creatin=
g a pool with 2048 pgs, 3 replicas, preparing 1 million 10MB objects, a=
nd then evaluating read performance of these objects.
>      We compared the PG & data distribution and read performance of t=
he two CRUSH algorithms, and got results as follows:
> 1.PG and data distribution is more balanced using optimized CRUSH alg=
orithm
>      a) For 2048 PGs with 3 replicas, stdev of PG# on 40 osds decreas=
es from 12.13 to 5.17; for 2048 PGs with 2 replicas, stdev of PG# on 40=
 osds decreases from 10.09 to 6.50
>      b) For 1 million 10MB objects with 3 replicas, stdev of disk use=
% on 40 osds decreases from 0.068 to 0.026; for 100 million 128KB objec=
ts with 2 replicas, stdev of disk use% on 40 osds decreases from 0.067 =
to 0.042
> 2.Large scaled performance is improved since data distribution is mor=
e balanced
>      a) More than 10% performance improvement for 128K and 10M read
>      b) Write performance not impacted
> Detailed performance data can be found in the http://tracker.ceph.com=
/attachments/download/1385/crush_optimization.pdf .
>=20
> We also created a pull request: https://github.com/ceph/ceph/pull/240=
2
>=20
>=20
> Thanks
> Jian
>=20
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sweil@redhat.com]
> Sent: Wednesday, September 10, 2014 9:06 AM
> To: Zhang, Jian
> Cc: Loic Dachary; ceph-devel@vger.kernel.org; He, Yujie
> Subject: RE: FW: CURSH optimization for unbalanced pg distribution
>=20
> The lists are rejecting the email because of the big attachments.  Se=
nd with links instead?
>=20
> On Tue, 9 Sep 2014, Zhang, Jian wrote:
>=20
>> Yujie sent out the following email yesterday, but it seems it was mi=
ssed. Resending it.
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Hi all,
>> ?  Several months ago we met an issue of read performance issues (17=
% degradation) when working on ceph object storage performance evaluati=
on with 10M objects (scaling from 10K objects to 1Million objects) , an=
d found the root cause is unbalanced pg distribution among all osd disk=
s, leading to unbalanced data distribution. We did some further investi=
gation then and identified that CRUSH failed to map pgs evenly to each =
osd. Please refer to the attached pdf (crush_proposals) for details.
>>
>> Key Message:
>> ?  As mentioned in the attached pdf, we described possible optimizat=
ion proposals for CRUSH and got some feedback from community (http://pe=
rmalink.gmane.org/gmane.comp.file-systems.ceph.devel/18979) . Sage sugg=
ested us take the idea of "Change placement strategy only for step of s=
electing devices from hosts", by adding a new bucket type called ?linea=
r?, and applying a modulo-like hash function to this kind of buckets to=
 achieve balanced distribution. We followed this suggestion and designe=
d an optimized CRUSH algorithm, with new hash methods and an adaptive m=
odule. Please refer to the Design and Implementation part for details. =
We also wrote some POC for it, see the attached patch. And as a result,=
 we got more than 10% read performance improvement using the optimized =
CRUSH algorithm.
>>
>> Design and Implementation:
>> 1.   Problem Identification
>> 1.1  Input key (pps) space of CRUSH is not uniform
>>      Since PG# on the nested devices of a host is not uniform even i=
f we select the device using simple modulo operation, we decide to chan=
ge the algorithm of hashing raw pg to pps.
>> 1.2  Algorithm of selecting items from buckets is not uniform
>>      After we get uniform input key space, we should make the proced=
ure of selecting devices from host be uniform. Since current CRUSH algo=
rithm uses Jenkins hash based strategies and failed to reach the goal, =
we decide to add a new bucket type and apply new (modulo based) hash al=
gorithm to make it.
>> 2.   Design
>> 2.1  New pps hash algorithm
>>      We design the new pps hash algorithm based on the "Congruential=
 pseudo-random number generator" (http://comjnl.oxfordjournals.org/cont=
ent/10/1/74.full.pdf) . It defines a bijection between the original seq=
uence {0, ...,2^N-1} and some permutation of it. In other words, given =
different keys between 0 and 2^N-1, the generator will produce differen=
t integers, but within the same range {0,...,2^N-1}.
>>      Assume there are np PGs in a pool, we can regard pgid (0?pgid<2=
^n, np?2^n<2*np) as the key, and then it will be hashed into a pps valu=
e between 0 and 2^n-1. Since PG# in a pool is usually 2^N, the generato=
r just shuffles the original pgid sequence as output in this case, maki=
ng the key space consisting of a permutation of {0,...,2^n-1}, which ac=
hieves the best uniformity. Moreover, poolid can be regarded as a seed =
in the generator, producing different pps value even with the same pgid=
 but different poolid. Therefore, pgid sequences of various pools are m=
apped into distinct pps sequences, getting rid of PG overlapping.
>> 2.2  New bucket type, Linear
>>      We introduce a new bucket type called "linear", and apply a new=
 modulo based hash algorithm to it. As the pps values assigned to each =
host are a pseudo-random subset of the original permutation and is poss=
ibly out of uniformity, in which situation applying modulo operation di=
rectly on integers in the subset cannot produce balanced distribution a=
mong disks in the host. To decrease deviation of the subset, we apply a=
 balance parameter 1/balance_param to the key before conducting the mod=
ulo method.
>>      For osd failure and recovery, it assumes that items nested in t=
his kind of bucket will not be removed, nor new items are added, same a=
s the UNIFORM bucket. Linear host will not introduce more data movement=
 than the uniform bucket.
>> 2.3  Adaptive Strategy
>>      Since there is no one constant balance parameter applying for a=
ll cases that will result in the best PG distribution. We make it an ad=
aptive procedure by adjusting the balance parameter automatically durin=
g the preparation for creating a new pool, according to different clust=
er topology, PG# and replica#, in order to gain a most uniform distribu=
tion.
>> ??1) Try different balance_param when preparing for a new pool
>> ????- Iteratively call CRUSH(map, ruleno, x, balance_param) to get
>> corresponding PG distribution with different balance_params
>> ????- Calculate stdev of PG# among all osds
>> ????- Choose the balance_param with the minimal stdev
>>   	2) Add a member variable to pool struct pg_pool_t to save the bes=
t
>> balance_param value ??The adaptive procedure can be described as fol=
lowing:
>> Input: cluster map, total PG number m, adaptive retry times n
>> Output: local optimal balance parameter balance_param min_pg_stdev =3D=
 MAX; balance_param =3D a; // initial value for trial from 0 to n {
>>      for pgid from 0 to m {
>>          calculate pps using the new generator in 2.1;
>>          for bucket b in cluster map // apply CRUSH algorithm
>>              apply corresponding bucket hashing algorithm and get a =
osd list for pgid
>>      }
>>      calculate pg_stdev_a by gathering all osd lists; // stdev of PG=
 distribution among all osds
>>      if pg_stdev_a < min_pg_stdev {
>>          min_pg_stdev =3D pg_stdev_a;
>>          balance_param =3D a;
>>      }
>>      adjust a to a new value;
>> }
>>
>>
>> Evaluation:
>>      We evaluated the performance of optimized and current CRUSH in =
a cluster consisting of 4 hosts, and each attaching with 10x1T disks. W=
e designed two test cases, for the first one, by creating a pool with 2=
048 pgs, 2 replicas, preparing 100 million 128KB objects, and then eval=
uating read performance of these objects; for the second one, by creati=
ng a pool with 2048 pgs, 3 replicas, preparing 1 million 10MB objects, =
and then evaluating read performance of these objects.
>>      We compared the PG & data distribution and read performance of =
the two CRUSH algorithms, and got results as follows:
>> 1.   PG and data distribution is more balanced using optimized CRUSH=
 algorithm
>> ??a) For 2048 PGs with 3 replicas, stdev of PG# on 40 osds decreases
>> from 12.13 to 5.17; for 2048 PGs with 2 replicas, stdev of PG# on 40
>> osds decreases from 10.09 to 6.50
>> ??b) For 1 million 10MB objects with 3 replicas, stdev of disk use% =
on 40 osds decreases from 0.068 to 0.026; for 100 million 128KB objects=
 with 2 replicas, stdev of disk use% on 40 osds decreases from 0.067 to=
 0.042
>> 2.   Large scaled performance is improved since data distribution is=
 more balanced
>> ??a) More than 10% performance improvement for 128K and 10M read
>> ??b) Write performance not impacted
>> Detailed performance data can be found in the attached pdf (crush_op=
timization).
>>
>> We also created a pull request: https://github.com/ceph/ceph/pull/24=
02
>>
>> Thanks
>> Jian
>>
>>
>> -----Original Message-----
>> From: Loic Dachary [mailto:loic@dachary.org]
>> Sent: Tuesday, September 09, 2014 9:36 PM
>> To: Zhang, Jian; ceph-devel@vger.kernel.org
>> Subject: Re: FW: CURSH optimization for unbalanced pg distribution
>>
>>
>>
>> On 20/03/2014 04:54, Zhang, Jian wrote:
>>> Forwarding per Sage's suggestion.
>>
>> Very interesting discussion :-) For the record the corresponding pul=
l
>> request is https://github.com/ceph/ceph/pull/2402
>>
>>>
>>>
>>> -----Original Message-----
>>> From: Sage Weil [mailto:sage@inktank.com]
>>> Sent: Wednesday, March 19, 2014 11:29 PM
>>> To: Mark Nelson
>>> Cc: Zhang, Jian; Duan, Jiangang; He, Yujie
>>> Subject: Re: CURSH optimization for unbalanced pg distribution
>>>
>>> On Wed, 19 Mar 2014, Mark Nelson wrote:
>>>> On 03/19/2014 03:24 AM, Zhang, Jian wrote:
>>>>> For more detail data, please refer to the *Testing results* part.
>>>>>
>>>>> *Optimization proposals: *
>>>>>
>>>>> After we dived into the source code of CRUSH and related papers,
>>>>> we proposed two possible optimizations:
>>>>>
>>>>> 1.Add different hash algorithms, as an alternative for the
>>>>> Jenkin's hash, e.g. algorithm that will produce even values when
>>>>> range of input value (pg#) is relatively small. Or add new bucket
>>>>> type at the same time if necessary.
>>>
>>> This *might* work, but I don't have a strong intuition about it.  T=
he modeling we've done now has essentially assumed a statistically unif=
orm distribution, which has some inherent inbalance for low values of n=
 (num pgs in our case).  I have generally assumed we can't do better th=
an "random", and still have the other properties we want (independent, =
deterministic placement), but it may be possible.
>>>
>>>>>
>>>>> 2.Find a better replica placement strategy instead of current
>>>>> retry logic of crush_choose_firstn, which may cause CRUSH to beha=
ve badly.
>>>>>
>>>>> We find there are several threshold of retry times by referring t=
o
>>>>> code, choose_total_tries, choose_local_tries and choose_local_fal=
lback_tries.
>>>>> They are used to decide whether to do a retry_bucket,
>>>>> retry_descent or use permutation to do an exhaustive bucket
>>>>> search. We are wondering if there is another retry strategy:
>>>>>
>>>>> a)Backtracking retry. Now the logic of crush_choose_firstn can
>>>>> only issue an retry either from the initial bucket(retry_descent)
>>>>> or from the current bucket (retry_bucket), how about retrying the=
 intervening buckets?
>>>>>
>>>>> b)Adjust threshold of retry times by other values. We do noticed
>>>>> that the 'optimal' crush tunable could be used to make it, but we
>>>>> still encounter unbalanced [g distribution by using the optimal s=
trategy.
>>>>> Please refer to 4 of the Testing results part.
>>>>>
>>>>> c)Add an mechanism that can adjust above mentioned thresholds
>>>>> adaptively. Maybe we can record the retry times of the previous
>>>>> call for CRUSH, and adjust retry thresholds automatically accordi=
ng to the record.
>>>
>>> I suggest ignoring all of this retry logic.  The original version o=
f
>>> CRUSH has the local retries to try to make data move "less far", bu=
t
>>> when we went back a year ago and did a statistical analysis of the
>>> distribution we found that *all* of these hacks degraded the qualit=
y
>>> of the placement,a nd by turning them all off (setting the 'optimal=
'
>>> values which zeroes them all out excent for total_retries) we got
>>> something that was indistinguishable from a uniform distribution.
>>>
>>>>> 3.Add soft link for pg directories. During pg creation, we can
>>>>> create soft links for the pgs if pg# on the selected osd is more
>>>>> than some threshold, say 10% more than desired average number, to
>>>>> move objects that will be stored in this pg to another osd.
>>>>> Balanced disk utilization may be gained in this way.
>>>
>>> I think you need to be careful, but yes, this is an option.  There
>>> is a similar exception mechanism in place that is used for other
>>> purposes and something similar could be done here.  The main
>>> challenge will be in ensuring that the soft links/exceptions follow
>>> the same overall policy that CRUSH does after the raw mapping is
>>> performed.  This is an option, but I would put it toward the bottom=
 of the list...
>>>
>>>>> 4.Change placement strategy only for step of selecting devices
>>>>> from hosts. We found in our testing results that pg distribution
>>>>> was balanced among hosts, which is reasonable since pg# of each
>>>>> host is above 1K (according to the current BKM that pg# per osd
>>>>> should be about 100). So how about we apply CRUSH only on the
>>>>> interval buckets and find another simple but more balanced method=
 to choose osd from host?
>>>
>>> This idea has a lot of potential.  For example:
>>>
>>> If you know the chassis can hold 12 disks, you can force the bucket
>>> size to twelve and somehow prevent users from adjusting the
>>> structure of the tree.  Then you can use a simple mapping that is
>>> truly flat (like a linear mapping, disk =3D x % num_disks) for that=
 bucket/subtree.
>>> The downside of course is that if you remove a disk *everything*
>>> reshuffles, hence some sort of guardrails to prevent a user from
>>> inadvertantly doing that.  If a disk *does* fail, you just need to
>>> make sure the disk is marked "out" but not removed from the CRUSH h=
ierarchy and the normal retry will kick in.
>>>
>>> Note that all this is reall doing is increasing the size of the "bu=
ckets"
>>> that we are (pseudo)randomly distribution over.  It is still a
>>> random/uniform distribution, but the N value is 12 times bigger (fo=
r
>>> a
>>> 12 disk chassis) and as a result the variance is substantially lowe=
r.
>>>
>>> I would suggest making a new bucket type that is called 'linear' an=
d
>>> does a simple modulo and trying this out.  We will need a bunch of
>>> additional safety checks to help users avoid doing silly things
>>> (like adjusting the number of items in the linear buckets, which
>>> reshuffle
>>> everything) but that wouldn't be needed for an initial analysis of =
the performance impact.
>>>
>>> Do you mind if we shift this thread over to ceph-devel?  I think
>>> there are lots of people who would be interested in this discussion=
=2E
>>> We can of course leave off your attachment if you prefer.
>>>
>>> Thanks!
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>> in the body of a message to majordomo@vger.kernel.org More majordom=
o
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>
> N=8B=A7=B2=E6=ECr=B8=9By=FA=E8=9A=D8b=B2X=AC=B6=C7=A7v=D8^=81=7F)=DE=BA=
{.n=81=7F+=89=B7=9Cz=98]z=F7=A5=8A{ay=81=7F=1D=CA=87=DA=99=81=7F,j=07=AD=
=A2f=A3=A2=B7h=9A=8B=E0z=81=7F=1E=AEw=A5=A2=81=7F=0C=A2=B7=A6j:+v=89=A8=
=8Aw=E8j=D8m=B6=9F=81=7F=81=7F=07=AB=91=EA=E7zZ+=83=F9=9A=8E=8A=DD=A2j"=
=9D=FA!tml=3D
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
