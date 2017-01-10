From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Hammer 0.94.10 release - last call
Date: Tue, 10 Jan 2017 14:52:07 +0100
Message-ID: <6e55e688-49df-72d2-58c4-ce86c67eeac8@suse.cz>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz>
 <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz>
 <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
 <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org>
 <CAC-Np1yn6i=FDM16rxOX8ZjXVj=u6GatC0u2tg8w9YHRvKZ9dw@mail.gmail.com>
 <ecd937e4-98df-b42e-8a57-5c8bb963fd54@suse.cz>
 <CAC-Np1yHUzoMCh72g6i1Ak75OPM-n=NgyE=-8HBCEvJYQAcG8Q@mail.gmail.com>
 <88567e66-9404-24dc-01b2-6bcd28899864@suse.cz>
 <CAC-Np1zqjJk5GvUEbxkVGoh36dnwcqSkcbRWzz4zew30ciTg5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754388AbdAJNwK (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Jan 2017 08:52:10 -0500
In-Reply-To: <CAC-Np1zqjJk5GvUEbxkVGoh36dnwcqSkcbRWzz4zew30ciTg5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

>> Sorry, I shouldn't have been so cryptic. I meant: if I prepare an
>> integration branch in ceph-ci and Shaman builds it, can you do a manual
>> test?
>
> Sure thing!

wip-hammer-backports now includes your PR and is ready for testing:

http://tracker.ceph.com/issues/17151#note-45
https://shaman.ceph.com/builds/ceph/wip-hammer-backports/

Thanks,
Nathan
