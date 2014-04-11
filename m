From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Fri, 11 Apr 2014 16:41:03 +0800
Message-ID: <CACJqLyb83UQxh6a0d_8Qa6duK9ab_QRScpQmNG_4otUt=yPb+w@mail.gmail.com>
References: <CAPYLRzixgjpxnwjGh5x5sXNN=+1Q9zf_LEa3u9O2xBxkeFgWkw@mail.gmail.com>
	<45c5720c-2773-4a99-adf9-0ed2ee36c144@mailpro>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:35597 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756128AbaDKIlE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Apr 2014 04:41:04 -0400
Received: by mail-wg0-f51.google.com with SMTP id k14so5113242wgh.10
        for <ceph-devel@vger.kernel.org>; Fri, 11 Apr 2014 01:41:03 -0700 (PDT)
In-Reply-To: <45c5720c-2773-4a99-adf9-0ed2ee36c144@mailpro>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Not fully, a object header also needed in KeyValueStore, but it's more
lightweight.

https://github.com/ceph/ceph/pull/1649

On Fri, Apr 11, 2014 at 2:04 PM, Alexandre DERUMIER <aderumier@odiso.co=
m> wrote:
>>>From explorations we and others have done, I think what we really wa=
nt
>>>to do here is make it cheaper to lookup and open files. The FileStor=
e
>>>is very much not optimized for this; a single lookup involves
>>>constructing the path from its components multiple times and I think
>>>even does the lookups more than once.
>>>Also, 250k or even 25k file descriptors is an awful lot to demand. ;=
)
>
> Could the new coming leveldb backend store help for this specific cas=
e ?
>
>
>
> ----- Mail original -----
>
> De: "Gregory Farnum" <greg@inktank.com>
> =C3=80: "Haomai Wang" <haomaiwang@gmail.com>
> Cc: ceph-devel@vger.kernel.org
> Envoy=C3=A9: Mercredi 9 Avril 2014 16:15:14
> Objet: Re: [Share]Performance tunning on Ceph FileStore with SSD back=
end
>
> On Wed, Apr 9, 2014 at 3:05 AM, Haomai Wang <haomaiwang@gmail.com> wr=
ote:
>> Hi all,
>>
>> I would like to share some ideas about how to improve performance on
>> ceph with SSD. Not much preciseness.
>>
>> Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).
>> ceph version is 0.67.5(Dumping)
>>
>> At first, we find three bottleneck on filestore:
>> 1. fdcache_lock(changed in Firely release)
>> 2. lfn_find in omap_* methods
>> 3. DBObjectMap header
>>
>> According to my understanding and the docs in
>> ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/Object=
Store.h),
>> I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully
>> sure the correctness of this change, but it works well still now.
>
> "Simply remove"? I don't remember all the details, but I'm sure
> there's more to it than that if you want things to behave.
>
>> DBObjectMap header patch is on the pull request queue and may be
>> merged in the next feature merge window.
>>
>> With things above done, we get much performance improvement in disk
>> util and benchmark results(3x-4x).
>>
>> Next, we find fdcache size become the main bottleneck. For example, =
if
>> hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If ho=
t
>> data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With
>> increase "filestore_fd_cache_size", the cost of lookup(FDCache) and
>> cache miss is expensive and can't be afford. The implementation of
>> FDCache isn't O(1). So we only can get high performance on fdcache h=
it
>> range(maybe 100GB with 10240 fdcache size) and more data exceed the
>> size of fdcaceh will be disaster. If you want to cache more fd(10240=
0
>> fdcache size), the implementation of FDCache will bring on extra CPU
>> cost(can't be ignore) for each op.
>
> From explorations we and others have done, I think what we really wan=
t
> to do here is make it cheaper to lookup and open files. The FileStore
> is very much not optimized for this; a single lookup involves
> constructing the path from its components multiple times and I think
> even does the lookups more than once.
> Also, 250k or even 25k file descriptors is an awful lot to demand. ;)
>
> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html



--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
