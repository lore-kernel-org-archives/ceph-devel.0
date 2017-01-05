From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Hammer 0.94.10 release - last call
Date: Thu, 5 Jan 2017 22:36:20 +0100
Message-ID: <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz>
 <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40465 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964850AbdAEVgY (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 5 Jan 2017 16:36:24 -0500
In-Reply-To: <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>

> Is it possible to re-do this PR that went into Jewel for Hammer?
>
> http://tracker.ceph.com/issues/17754

OK, https://github.com/ceph/ceph/pull/12805

Any suggestions how to test it? I.e. do you know if there's a teuthology 
or ceph-qa-suite task that exercises ceph-create-keys?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
