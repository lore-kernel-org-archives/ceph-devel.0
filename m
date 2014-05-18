From: Guang <yguang11@outlook.com>
Subject: Re: Radosgw - bucket index
Date: Sun, 18 May 2014 14:25:13 +0800
Message-ID: <BLU436-SMTP15995ECEE2C5FA8E935D70EDF330@phx.gbl>
References: <alpine.DEB.2.00.1405061757540.28165@cobra.newdream.net> <BLU436-SMTP195A770E0A729DF4723DD28DF310@phx.gbl> <alpine.DEB.2.00.1405160600320.28306@cobra.newdream.net> <CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [65.55.111.158] ([65.55.111.158]:46856 "EHLO
	blu0-omc4-s19.blu0.hotmail.com" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752030AbaERG0b convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 May 2014 02:26:31 -0400
In-Reply-To: <CABBk=J_p9dDQBhvhbXrDmUonsY_TW5ZFDWuQqw3DGukVSRJeKg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>, Sage Weil <sage@inktank.com>
Cc: haomaiwang@gmail.com, Ceph-devel <ceph-devel@vger.kernel.org>

Thanks Sage and Yehuda.
On May 17, 2014, at 12:42 AM, Yehuda Sadeh <yehuda@inktank.com> wrote:

> On Fri, May 16, 2014 at 6:09 AM, Sage Weil <sage@inktank.com> wrote:
>> Hi Guang,
>>=20
>> [I think the problem is that your email is HTML formatted, and vger
>> silently drops those.  Make sure your mailer is set to plain text mo=
de.]
Yeah, thanks Sage! My Yahoo account failed to to a change at Yahoo! sid=
e [1] and my outlook account failed with the HTML format, changed it to=
 plain text.
[1]  http://thehackernews.com/2014/04/yahoos-new-dmarc-policy-destroys-=
every.html
>>=20
>> On Fri, 16 May 2014, Guang wrote:
>>=20
>>>      * *Key/value OSD backend* (experimental): An alternative stora=
ge
>>>      backend
>>>       for Ceph OSD processes that puts all data in a key/value
>>>      database like
>>>       leveldb.  This provides better performance for workloads
>>>      dominated by
>>>       key/value operations (like radosgw bucket indices).
>>>=20
>>> Hi Yehuda and Haomai,I managed to set up a K/V store backend and pl=
ayed
>>> around with it, as Sage mentioned in the release note, I thought K/=
V store
>>> could be the solution for radosgw?s bucket indexing feature which c=
urrently
>>> has scaling problems [1], however, after playing around with K/V st=
ore and
>>> understanding the requirement for bucket indexing, I think at least=
 for now
>>> there is still gap to fix the bucket indexing by leveraging the K/V=
 store.
>>>=20
>>> In my opinion, one requirement (API) to implement bucket indexing i=
s to
>>> support ordered scan (prefix filter), which is not part of the API =
of rados,
>>> and as K/V store does not extend the rados API (it is not supposed =
to) but
>>> only  change the underlying object store strategy. It is not likely=
 to help
>>> for the bucket indexing, except that we use the original way using =
omap to
>>> store bucket indexing and each bucket corresponds to one object.
>>=20
>> The rados omap API does allow a prefix filter, although it's somewha=
t
>> implicit:
>>=20
>>    /**
>>     * omap_get_keys: keys from the object omap
>>     *
>>     * Get up to max_return keys beginning after start_after
>>     *
>>     * @param start_after [in] list keys starting after start_after
>>     * @parem max_return [in] list no more than max_return keys
>>     * @param out_keys [out] place returned values in out_keys on com=
pletion
>>     * @param prval [out] place error code in prval upon completion
>>     */
>>    void omap_get_keys(const std::string &start_after,
>>                       uint64_t max_return,
>>                       std::set<std::string> *out_keys,
>>                       int *prval);
>>=20
>> Since all keys are sorted alphanumerically, you simply have to set
>> start_after =3D=3D your prefix, and start ignoring the results once =
you get a
>> key that does not contain your prefix.  This could be improved by ha=
ving
>> an explicit prefix argument that does this server-side, but for now =
at you
>> can get the right data (plus a bit a extra at the end).
I think this is the API currently being used to implement the bucket in=
dexing, and it operates on object basis, which makes it unscalable, e.g=
=2E two requests updating the same index object will need to be seriali=
zed at OSD side.
>>=20
>> Is that what you mean by prefix scan, or are you referring to the ab=
ility
>> to scan for rados objects that begin with a prefix?  If it's the lat=
ter,
>> you are right: objects are hashed across nodes and there is no sorte=
d
>> object name index to allow prefix filtering.  There is a list_object=
s
>> filter option, but it is still O(objects in the pool).
By prefix scan, I was referring to a radios objects level API (so that =
we can leverage the new K/V store to improve the scalability, that is, =
different bucket index entries are actually refer to different rados ob=
jects, which makes it scalable). As this is not true, we are not likely=
 to leverage K/V store backend to simply solve the bucket indexing issu=
e.
>>=20
>>> Did I miss anything obvious here?
>>>=20
>>> We are very interested in the effort to improve the scalability of =
bucket
>>> index [1] as the blueprint mentioned, here is my thoughts on top of=
 this:
>>> 1. It would be nice we can refactor the interface so that it is eas=
y to
>>> switch to a different underlying storage system for bucket indexing=
, for
>>> example, DynamoDB seems like being used for S3?s implementation [2]=
, and SWIFT
>>> uses sqllite [1] and has a flat namespace for listing purpose (with=
 prefix
>>> and delimiter).
>>=20
>> radosgw is using the omap key/value API for objects, which is more o=
r less
>> equivalent to what swift is doing with sqlite.  This data passes str=
aight
>> into leveldb on the backend (or whatever other backend you are using=
).
>> Using something like rocksdb in its place is pretty simple and ther =
are
>> unmerged patches to do that; the user would just need to adjust thei=
r
>> crush map so that the rgw index pool is mapped to a different set of=
 OSDs
>> with the better k/v backend.
Not sure if I miss anything, but the key difference with SWIFT=92s impl=
ementation is that they are using a table for bucket index and it actua=
lly can be updated in parallel which makes more scalable for write, tho=
ugh at certain point the sql table would result in performance degradat=
ion as well.
>>=20
>>> 2. As mentioned in the blueprint, if we go with the approach to do =
sharding
>>> for the bucket index object, what is the design choice? Are we goin=
g to
>>> maintain a B- tree structure get all keys sorted and sharidng on de=
mand,
>>> like having a background thread do the sharding when it reaches a c=
ertain
>>> threshold?
>>=20
>> I don't know... I'm sure Yehuda has a more well-formed opinion on th=
is.  I
>> suspect something simpler than a B tree (like a single-level hash-ba=
sed
>> fan out) would be sufficient, although you'd pay a bit of a price fo=
r
>> object enumeration.
>>=20
>=20
> My more well-formed opinion is that we need to come up with a good
> design. It needs to be flexible enough to be able to grow (and maybe
> shrink), and I assume there would be some kind of background operatio=
n
> that will enable that. I also believe that making it hash based is th=
e
> way to go. It looks like that the more complicated issue is here is
> how to handle the transition in which we shard buckets.
Yeah I agree. I think the conflicting goals here are, we want a sorted =
list (so that it enable prefix scan for listing purpose) and we want to=
 shard at the very beginning (the problem we are facing is parallel wri=
tes updating the same bucket index object will need to be serialized).
> Yehuda
>=20

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
