From: Loic Dachary <loic@dachary.org>
Subject: Re: FW: CURSH optimization for unbalanced pg distribution
Date: Tue, 09 Sep 2014 15:36:18 +0200
Message-ID: <540F0252.7040609@dachary.org>
References: <51FC7A40FB29414D88A121A7FFEF9A4710DC2188@SHSMSX104.ccr.corp.intel.com> <53299E33.5060809@inktank.com> <alpine.DEB.2.00.1403190814520.316@cobra.newdream.net> <51FC7A40FB29414D88A121A7FFEF9A4710DC3018@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="2TebQ523cGe7e1KTWNl4uuRAvMkVXG2I2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:48192 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756614AbaIINg2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Sep 2014 09:36:28 -0400
In-Reply-To: <51FC7A40FB29414D88A121A7FFEF9A4710DC3018@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhang, Jian" <jian.zhang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2TebQ523cGe7e1KTWNl4uuRAvMkVXG2I2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 20/03/2014 04:54, Zhang, Jian wrote:
> Forwarding per Sage's suggestion.=20

Very interesting discussion :-) For the record the corresponding pull req=
uest is https://github.com/ceph/ceph/pull/2402

>=20
>=20
> -----Original Message-----
> From: Sage Weil [mailto:sage@inktank.com]=20
> Sent: Wednesday, March 19, 2014 11:29 PM
> To: Mark Nelson
> Cc: Zhang, Jian; Duan, Jiangang; He, Yujie
> Subject: Re: CURSH optimization for unbalanced pg distribution
>=20
> On Wed, 19 Mar 2014, Mark Nelson wrote:
>> On 03/19/2014 03:24 AM, Zhang, Jian wrote:
>>> For more detail data, please refer to the *Testing results* part.
>>>
>>> *Optimization proposals: *
>>>
>>> After we dived into the source code of CRUSH and related papers, we=20
>>> proposed two possible optimizations:
>>>
>>> 1.Add different hash algorithms, as an alternative for the Jenkin's=20
>>> hash, e.g. algorithm that will produce even values when range of=20
>>> input value (pg#) is relatively small. Or add new bucket type at the =

>>> same time if necessary.
>=20
> This *might* work, but I don't have a strong intuition about it.  The m=
odeling we've done now has essentially assumed a statistically uniform di=
stribution, which has some inherent inbalance for low values of n (num pg=
s in our case).  I have generally assumed we can't do better than "random=
", and still have the other properties we want (independent, deterministi=
c placement), but it may be possible.
>=20
>>>
>>> 2.Find a better replica placement strategy instead of current retry
>>> logic of crush_choose_firstn, which may cause CRUSH to behave badly.
>>>
>>> We find there are several threshold of retry times by referring to co=
de,
>>> choose_total_tries, choose_local_tries and choose_local_fallback_trie=
s.
>>> They are used to decide whether to do a retry_bucket, retry_descent o=
r
>>> use permutation to do an exhaustive bucket search. We are wondering i=
f
>>> there is another retry strategy:
>>>
>>> a)Backtracking retry. Now the logic of crush_choose_firstn can only
>>> issue an retry either from the initial bucket(retry_descent) or from =
the
>>> current bucket (retry_bucket), how about retrying the intervening buc=
kets?
>>>
>>> b)Adjust threshold of retry times by other values. We do noticed that=

>>> the 'optimal' crush tunable could be used to make it, but we still
>>> encounter unbalanced [g distribution by using the optimal strategy.
>>> Please refer to 4 of the Testing results part.
>>>
>>> c)Add an mechanism that can adjust above mentioned thresholds
>>> adaptively. Maybe we can record the retry times of the previous call =
for
>>> CRUSH, and adjust retry thresholds automatically according to the rec=
ord.
>=20
> I suggest ignoring all of this retry logic.  The original version of CR=
USH=20
> has the local retries to try to make data move "less far", but when we =

> went back a year ago and did a statistical analysis of the distribution=
 we=20
> found that *all* of these hacks degraded the quality of the placement,a=
 nd=20
> by turning them all off (setting the 'optimal' values which zeroes them=
=20
> all out excent for total_retries) we got something that was=20
> indistinguishable from a uniform distribution.
>=20
>>> 3.Add soft link for pg directories. During pg creation, we can create=

>>> soft links for the pgs if pg# on the selected osd is more than some
>>> threshold, say 10% more than desired average number, to move objects
>>> that will be stored in this pg to another osd. Balanced disk utilizat=
ion
>>> may be gained in this way.
>=20
> I think you need to be careful, but yes, this is an option.  There is a=
=20
> similar exception mechanism in place that is used for other purposes an=
d=20
> something similar could be done here.  The main challenge will be in=20
> ensuring that the soft links/exceptions follow the same overall policy =

> that CRUSH does after the raw mapping is performed.  This is an option,=
=20
> but I would put it toward the bottom of the list...
>=20
>>> 4.Change placement strategy only for step of selecting devices from
>>> hosts. We found in our testing results that pg distribution was balan=
ced
>>> among hosts, which is reasonable since pg# of each host is above 1K
>>> (according to the current BKM that pg# per osd should be about 100). =
So
>>> how about we apply CRUSH only on the interval buckets and find anothe=
r
>>> simple but more balanced method to choose osd from host?
>=20
> This idea has a lot of potential.  For example:
>=20
> If you know the chassis can hold 12 disks, you can force the bucket siz=
e=20
> to twelve and somehow prevent users from adjusting the structure of the=
=20
> tree.  Then you can use a simple mapping that is truly flat (like a lin=
ear=20
> mapping, disk =3D x % num_disks) for that bucket/subtree.  The downside=
 of=20
> course is that if you remove a disk *everything* reshuffles, hence some=
=20
> sort of guardrails to prevent a user from inadvertantly doing that.  If=
 a=20
> disk *does* fail, you just need to make sure the disk is marked "out" b=
ut=20
> not removed from the CRUSH hierarchy and the normal retry will kick in.=

>=20
> Note that all this is reall doing is increasing the size of the "bucket=
s"=20
> that we are (pseudo)randomly distribution over.  It is still a=20
> random/uniform distribution, but the N value is 12 times bigger (for a =
12=20
> disk chassis) and as a result the variance is substantially lower.
>=20
> I would suggest making a new bucket type that is called 'linear' and do=
es=20
> a simple modulo and trying this out.  We will need a bunch of additiona=
l=20
> safety checks to help users avoid doing silly things (like adjusting th=
e=20
> number of items in the linear buckets, which reshuffle everything) but =

> that wouldn't be needed for an initial analysis of the performance impa=
ct.
>=20
> Do you mind if we shift this thread over to ceph-devel?  I think there =
are=20
> lots of people who would be interested in this discussion.  We can of=20
> course leave off your attachment if you prefer.
>=20
> Thanks!
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--2TebQ523cGe7e1KTWNl4uuRAvMkVXG2I2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEUEARECAAYFAlQPAlIACgkQ8dLMyEl6F23xRgCgouC0xqGtrYSzoZ9QyYzieNgL
eEAAmNicEEQdNW1S51UsSJmL3X6OtjM=
=/xuV
-----END PGP SIGNATURE-----

--2TebQ523cGe7e1KTWNl4uuRAvMkVXG2I2--
