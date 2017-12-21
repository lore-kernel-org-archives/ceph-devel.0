From: Brad Hubbard <bhubbard@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Thu, 21 Dec 2017 14:03:24 +1000
Message-ID: <CAF-wwdHbN3dawfA9FKqqfQObhoKotFV0M490f44RNqoxv7TGBg@mail.gmail.com>
References: <5a3b1452921a0_20dd327328244d2@ss1435.mail> <81f1da2d-75b4-ab4a-2933-65e3794192a5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:41960 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756192AbdLUED0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 20 Dec 2017 23:03:26 -0500
Received: by mail-io0-f174.google.com with SMTP id o2so19551575ioe.8
        for <ceph-devel@vger.kernel.org>; Wed, 20 Dec 2017 20:03:26 -0800 (PST)
In-Reply-To: <81f1da2d-75b4-ab4a-2933-65e3794192a5@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Devel <ceph-devel@vger.kernel.org>

On Thu, Dec 21, 2017 at 1:34 PM, Jos Collin <jcollin@redhat.com> wrote:
>
>
> On Thursday 21 December 2017 07:24 AM, scan-admin@coverity.com wrote:
>>
>>
>> Hi,
>>
>> Please find the latest report on new defect(s) introduced to ceph found
>> with Coverity Scan.
>>
>> 3 new defect(s) introduced to ceph found with Coverity Scan.
>> 11 defect(s), reported by Coverity Scan earlier, were marked fixed in the
>> recent build analyzed by Coverity Scan.
>>
>> New defect(s) Reported-by: Coverity Scan
>> Showing 3 of 3 defect(s)
>>
>>
>> ** CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
>> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1270 in
>> MDBalancer::dump_loads(ceph::Formatter *)()
>>
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
>> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1270 in
>> MDBalancer::dump_loads(ceph::Formatter *)()
>> 1264
>> 1265       f->open_array_section("dirfrags");
>> 1266       while (!dfs.empty()) {
>> 1267         CDir *dir = dfs.front();
>> 1268         dfs.pop_front();
>> 1269
>>>>>
>>>>>      CID 1426746:  Null pointer dereferences  (REVERSE_INULL)
>>>>>      Null-checking "f" suggests that it may be null, but it has already
>>>>> been dereferenced on all paths leading to the check.
>>
>> 1270         if (f) {

This check for f being null is redundant since if it were null we
would have segfaulted on line 1263 or 1265.

I'd suggest it can be removed. We could put an assert put at the start
of the function if necessary/desirable  to check the Formatter
argument being passed in but I haven't looked into it that deeply and
I'm not sure that's necessary. I'd also suggest taking a look at
similar functions that take a "Formatter" argument and see how they
handle the possibility of the Formatter being null.

>> 1271           f->open_object_section("dir");
>> 1272           dir->dump_load(f, now, decayrate);
>> 1273           f->close_section();
>> 1274         }
>> 1275
>>
>> ** CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
>> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1290 in
>> MDBalancer::dump_loads(ceph::Formatter *)()
>
>
> There is a possibility that `f` might be NULL. But it is not NULL.
>
> Please see:
> https://github.com/ceph/ceph/blob/f33ab7e03a13e18c8c883284033d511f1b43df12/src/mds/MDSDaemon.cc#L135
>
>>
>>
>>
>> ________________________________________________________________________________________________________
>> *** CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
>> /home/brad/working/src/ceph/src/mds/MDBalancer.cc: 1290 in
>> MDBalancer::dump_loads(ceph::Formatter *)()
>> 1284            if (subdir->pop_nested.meta_load() < .001)
>> 1285              continue;
>> 1286            dfs.push_back(subdir);
>> 1287           }
>> 1288         }
>> 1289       }
>>>>>
>>>>>      CID 1426747:  Null pointer dereferences  (FORWARD_NULL)
>>>>>      Passing null pointer "f" to "close_section", which dereferences
>>>>> it. (The dereference happens because this is a virtual function call.)
>>
>> 1290       f->close_section();  // dirfrags array
>> 1291
>> 1292       f->open_object_section("mds_load");
>> 1293       {
>> 1294
>> 1295         auto dump_mds_load = [this, f, now](mds_load_t& load) {
>>
>> ** CID 1426748:  Uninitialized members  (UNINIT_CTOR)
>> /home/brad/working/src/ceph/src/osd/ECBackend.h: 511 in
>> ECBackend::Op::Op()()
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Cheers,
Brad
