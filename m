From: Loic Dachary <loic@dachary.org>
Subject: Re: Hammer 0.94.10 release - last call
Date: Fri, 6 Jan 2017 01:12:25 +0100
Message-ID: <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz>
 <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz>
 <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48324 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162196AbdAFAMa (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Jan 2017 19:12:30 -0500
In-Reply-To: <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


On 01/05/2017 10:47 PM, Yuri Weinstein wrote:
> May ceph-disk ?
> Loic FYI

What Nathan said, unfortunately. No ceph-disk tests in hammer. And backporting tests would require changes in ceph-disk that are too extensive for a stable branch.

> 
> On Thu, Jan 5, 2017 at 1:36 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>>> Is it possible to re-do this PR that went into Jewel for Hammer?
>>>
>>> http://tracker.ceph.com/issues/17754
>>
>>
>> OK, https://github.com/ceph/ceph/pull/12805
>>
>> Any suggestions how to test it? I.e. do you know if there's a teuthology or
>> ceph-qa-suite task that exercises ceph-create-keys?
>>
>>
>> --
>> Nathan Cutler
>> Software Engineer Distributed Storage
>> SUSE LINUX, s.r.o.
>> Tel.: +420 284 084 037
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Loïc Dachary, Artisan Logiciel Libre
