From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [Share]Performance tunning on Ceph FileStore with SSD backend
Date: Fri, 11 Apr 2014 08:04:15 +0200 (CEST)
Message-ID: <45c5720c-2773-4a99-adf9-0ed2ee36c144@mailpro>
References: <CAPYLRzixgjpxnwjGh5x5sXNN=+1Q9zf_LEa3u9O2xBxkeFgWkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:47921 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbaDKGEY convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Apr 2014 02:04:24 -0400
In-Reply-To: <CAPYLRzixgjpxnwjGh5x5sXNN=+1Q9zf_LEa3u9O2xBxkeFgWkw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: ceph-devel@vger.kernel.org, Haomai Wang <haomaiwang@gmail.com>

>>From explorations we and others have done, I think what we really wan=
t
>>to do here is make it cheaper to lookup and open files. The FileStore
>>is very much not optimized for this; a single lookup involves
>>constructing the path from its components multiple times and I think
>>even does the lookups more than once.
>>Also, 250k or even 25k file descriptors is an awful lot to demand. ;)

Could the new coming leveldb backend store help for this specific case =
?



----- Mail original -----=20

De: "Gregory Farnum" <greg@inktank.com>=20
=C3=80: "Haomai Wang" <haomaiwang@gmail.com>=20
Cc: ceph-devel@vger.kernel.org=20
Envoy=C3=A9: Mercredi 9 Avril 2014 16:15:14=20
Objet: Re: [Share]Performance tunning on Ceph FileStore with SSD backen=
d=20

On Wed, Apr 9, 2014 at 3:05 AM, Haomai Wang <haomaiwang@gmail.com> wrot=
e:=20
> Hi all,=20
>=20
> I would like to share some ideas about how to improve performance on=20
> ceph with SSD. Not much preciseness.=20
>=20
> Our ssd is 500GB and each OSD own a SSD(journal is on the same SSD).=20
> ceph version is 0.67.5(Dumping)=20
>=20
> At first, we find three bottleneck on filestore:=20
> 1. fdcache_lock(changed in Firely release)=20
> 2. lfn_find in omap_* methods=20
> 3. DBObjectMap header=20
>=20
> According to my understanding and the docs in=20
> ObjectStore.h(https://github.com/ceph/ceph/blob/master/src/os/ObjectS=
tore.h),=20
> I simply remove lfn_find in omap_* and fdcache_lock. I'm not fully=20
> sure the correctness of this change, but it works well still now.=20

"Simply remove"? I don't remember all the details, but I'm sure=20
there's more to it than that if you want things to behave.=20

> DBObjectMap header patch is on the pull request queue and may be=20
> merged in the next feature merge window.=20
>=20
> With things above done, we get much performance improvement in disk=20
> util and benchmark results(3x-4x).=20
>=20
> Next, we find fdcache size become the main bottleneck. For example, i=
f=20
> hot data range is 100GB, we need 25000(100GB/4MB) fd to cache. If hot=
=20
> data range is 1TB, we need 250000(1000GB/4MB) fd to cache. With=20
> increase "filestore_fd_cache_size", the cost of lookup(FDCache) and=20
> cache miss is expensive and can't be afford. The implementation of=20
> FDCache isn't O(1). So we only can get high performance on fdcache hi=
t=20
> range(maybe 100GB with 10240 fdcache size) and more data exceed the=20
> size of fdcaceh will be disaster. If you want to cache more fd(102400=
=20
> fdcache size), the implementation of FDCache will bring on extra CPU=20
> cost(can't be ignore) for each op.=20

=46rom explorations we and others have done, I think what we really wan=
t=20
to do here is make it cheaper to lookup and open files. The FileStore=20
is very much not optimized for this; a single lookup involves=20
constructing the path from its components multiple times and I think=20
even does the lookups more than once.=20
Also, 250k or even 25k file descriptors is an awful lot to demand. ;)=20

-Greg=20
Software Engineer #42 @ http://inktank.com | http://ceph.com=20
--=20
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n=20
the body of a message to majordomo@vger.kernel.org=20
More majordomo info at http://vger.kernel.org/majordomo-info.html=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
