From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: radosgw 0.67.2 update -> "ERROR: failed to initialize watch"
Date: Thu, 29 Aug 2013 14:59:43 +0200
Message-ID: <CAF6-1L7z8i4NfYT4NC8ymFo1p1WTkxxdi2==AUFtEA_7J1fK1w@mail.gmail.com>
References: <CAF6-1L66AG8a1N0ujFvAbYYgXTZ41ug6HtiLvPY8c_AEriHXAw@mail.gmail.com>
	<CAF6-1L67azE9qJpsmFWAPdjD+yd9WmPKRoLxGe9pS5GDnHE=pQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:57752 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752272Ab3H2M7n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Aug 2013 08:59:43 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so418464pbb.14
        for <ceph-devel@vger.kernel.org>; Thu, 29 Aug 2013 05:59:43 -0700 (PDT)
In-Reply-To: <CAF6-1L67azE9qJpsmFWAPdjD+yd9WmPKRoLxGe9pS5GDnHE=pQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I tried going back to a src/rgw/ directory as it is in the 0.67.2
release, but didn't start either.

(failed to init storage).

Finally I disabled the cache for now and it seem to have started properly.

On Thu, Aug 29, 2013 at 1:50 PM, Sylvain Munaut
<s.munaut@whatever-company.com> wrote:
> I reverted commit a4cca31c82bf0e84272e01eb1b3188dfdb5b5615 and then I got :
>
> 2013-08-29 13:32:44.430574 7f55402a7780  0 ceph version
> 0.67.2-19-gc81bc5b (c81bc5b59dda37f54c02039ca3d5aada64076624), process
> lt-radosgw, pid 30786
> 2013-08-29 13:32:44.430608 7f55402a7780 -1 WARNING: libcurl doesn't
> support curl_multi_wait()
> 2013-08-29 13:32:44.430619 7f55402a7780 -1 WARNING: cross zone /
> region transfer performance may be affected
> 2013-08-29 13:32:44.451041 7f552f6fd700  2
> RGWDataChangesLog::ChangesRenewThread: start
> 2013-08-29 13:32:44.453327 7f55402a7780 10 cache get:
> name=.rgw+.pools.avail : miss
> 2013-08-29 13:32:44.457216 7f55402a7780 10 cache put: name=.rgw+.pools.avail
> 2013-08-29 13:32:44.457256 7f55402a7780 10 adding .rgw+.pools.avail to
> cache LRU end
> 2013-08-29 13:32:44.458385 7f55402a7780 -1 error storing zone params:
> (1) Operation not permitted
> 2013-08-29 13:32:44.460492 7f55402a7780 -1 Couldn't init storage
> provider (RADOS)
>
>
> So I tried creating .rgw.root pool manually (even though the docs in
> http://ceph.com/docs/next/radosgw/config/ don't list it) and that went
> to :
>
>
> 2013-08-29 13:45:37.454387 7f46da40b780  0 ceph version
> 0.67.2-19-gc81bc5b (c81bc5b59dda37f54c02039ca3d5aada64076624), process
> lt-radosgw, pid 31234
> 2013-08-29 13:45:37.454433 7f46da40b780 -1 WARNING: libcurl doesn't
> support curl_multi_wait()
> 2013-08-29 13:45:37.454446 7f46da40b780 -1 WARNING: cross zone /
> region transfer performance may be affected
> 2013-08-29 13:45:37.473025 7f46c97fa700  2
> RGWDataChangesLog::ChangesRenewThread: start
> 2013-08-29 13:45:37.473499 7f46da40b780 20 get_obj_state:
> rctx=0xdb2cd0 obj=.rgw.root:default.region state=0xdaffc8
> s->prefetch_data=0
> 2013-08-29 13:45:37.473531 7f46da40b780 10 cache get:
> name=.rgw.root+default.region : miss
> 2013-08-29 13:45:37.487496 7f46da40b780 10 cache put:
> name=.rgw.root+default.region
> 2013-08-29 13:45:37.487548 7f46da40b780 10 adding
> .rgw.root+default.region to cache LRU end
> 2013-08-29 13:45:37.487626 7f46da40b780 10 cache get:
> name=.rgw+.pools.avail : miss
> 2013-08-29 13:45:37.491370 7f46da40b780 10 cache put: name=.rgw+.pools.avail
> 2013-08-29 13:45:37.491393 7f46da40b780 10 adding .rgw+.pools.avail to
> cache LRU end
> 2013-08-29 13:45:37.491448 7f46da40b780  0 PN: .rgw.root OID: zone_info.default
> 2013-08-29 13:45:37.531675 7f46da40b780 10 cache put:
> name=.rgw.root+zone_info.default
> 2013-08-29 13:45:37.531697 7f46da40b780 10 adding
> .rgw.root+zone_info.default to cache LRU end
> *** Caught signal (Floating point exception) **
>  in thread 7f46da40b780
>  ceph version 0.67.2-19-gc81bc5b (c81bc5b59dda37f54c02039ca3d5aada64076624)
>  1: /home/whatever/ceph/src/.libs/lt-radosgw() [0x573bfa]
>  2: (()+0xfcb0) [0x7f46d8d3acb0]
>  3: (RGWRados::pick_control_oid(std::string const&,
> std::string&)+0x35) [0x4dd855]
>  4: (RGWRados::distribute(std::string const&,
> ceph::buffer::list&)+0x3f) [0x4dd91f]
>  5: (RGWCache<RGWRados>::distribute_cache(std::string const&,
> rgw_obj&, ObjectCacheInfo&, int)+0x3d7) [0x510b37]
>  6: (RGWCache<RGWRados>::put_obj_meta_impl(void*, rgw_obj&, unsigned
> long, long*, std::map<std::string, ceph::buffer::list,
> std::less<std::string>, std::allocator<std::pair<std::string const,
> ceph::buffer::list> > >&, RGWObjCategory, int, std::map<std::string,
> ceph::buffer::list, std::less<std::string>,
> std::allocator<std::pair<std::string const, ceph::buffer::list> > >*,
> ceph::buffer::list const*, RGWObjManifest*, std::string const*,
> std::list<std::string, std::allocator<std::string> >*, bool,
> RGWObjVersionTracker*, long)+0x2ab) [0x511dab]
>  7: (RGWRados::put_obj_meta(void*, rgw_obj&, unsigned long,
> std::map<std::string, ceph::buffer::list, std::less<std::string>,
> std::allocator<std::pair<std::string const, ceph::buffer::list> > >&,
> RGWObjCategory, int, RGWRados::PutObjMetaExtraParams&)+0x6f)
> [0x500e0f]
>  8: (rgw_put_system_obj(RGWRados*, rgw_bucket&, std::string&, char
> const*, unsigned long, bool, RGWObjVersionTracker*, long,
> std::map<std::string, ceph::buffer::list, std::less<std::string>,
> std::allocator<std::pair<std::string const, ceph::buffer::list> >
>>*)+0x2c4) [0x4daba4]
>  9: (RGWZoneParams::store_info(CephContext*, RGWRados*,
> RGWRegion&)+0x17c) [0x4e40dc]
>  10: (RGWRegion::create_default()+0x487) [0x4ed5f7]
>  11: (RGWRegion::init(CephContext*, RGWRados*, bool)+0x108) [0x4edb38]
>  12: (RGWRados::init_complete()+0x32) [0x4efd82]
>  13: (RGWStoreManager::init_storage_provider(CephContext*,
> bool)+0x621) [0x4e98c1]
>  14: (main()+0x441) [0x4579c1]
>  15: (__libc_start_main()+0xed) [0x7f46d7a4d76d]
>  16: /home/whatever/ceph/src/.libs/lt-radosgw() [0x459789]
> 2013-08-29 13:45:37.555982 7f46da40b780 -1 *** Caught signal (Floating
> point exception) **
>  in thread 7f46da40b780
>
>
> Cheers,
>
>     Sylvain
>
>
> On Thu, Aug 29, 2013 at 11:53 AM, Sylvain Munaut
> <s.munaut@whatever-company.com> wrote:
>> Hi,
>>
>> I just updated our test cluster to 0.67.2+ (latest dumpling branch) (
>> from 0.61.x ) and radosgw refuses to start.
>>
>>
>> 2013-08-29 11:46:34.915552 7ffccbc3d780  0 ceph version
>> 0.67.2-19-gc81bc5b (c81bc5b59dda37f54c02039ca3d5aada64076624), process
>> lt-radosgw, pid 30404
>> 2013-08-29 11:46:34.915598 7ffccbc3d780 -1 WARNING: libcurl doesn't
>> support curl_multi_wait()
>> 2013-08-29 11:46:34.915612 7ffccbc3d780 -1 WARNING: cross zone /
>> region transfer performance may be affected
>> 2013-08-29 11:46:34.935674 7ffcb2ffd700  2
>> RGWDataChangesLog::ChangesRenewThread: start
>> 2013-08-29 11:46:34.937337 7ffccbc3d780 -1 ERROR: failed to initialize watch
>> 2013-08-29 11:46:34.939135 7ffccbc3d780 -1 Couldn't init storage
>> provider (RADOS)
>>
>> in RGWRados::init_watch(), it seems that :
>>
>> const char *control_pool = zone.control_pool.name.c_str()
>>
>> returns an empty string which is really suspect ...
>>
>>
>> Cheers,
>>
>>     Sylvain
>
>
>
> --
> Sylvain Munaut
> Whatever s.a.
> Rue Fond Cattelain 5
> 1435 Mont-Saint-Guibert
> Fixed line: +32 10 23.59.30



-- 
Sylvain Munaut
Whatever s.a.
Rue Fond Cattelain 5
1435 Mont-Saint-Guibert
Fixed line: +32 10 23.59.30
