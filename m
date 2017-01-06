From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Hammer 0.94.10 release - last call
Date: Fri, 6 Jan 2017 15:13:27 +0100
Message-ID: <ecd937e4-98df-b42e-8a57-5c8bb963fd54@suse.cz>
References: <8c0ffdf7-a8db-5a3d-6e4b-afe31f52319f@suse.cz>
 <CAC-Np1yQrOBeeWzxAgy4aebXwGOi3d4i2VK7Yscn4O802-7uCA@mail.gmail.com>
 <9b4076a3-3e4a-8cd7-4db5-549d277fc4f8@suse.cz>
 <CAMMFjmFVYCKv=OgOjibn_tKEzQdpFGV+yhLP11VRzhxjhfNoOg@mail.gmail.com>
 <243fa727-c055-d1a0-6f51-5f5db87ed953@dachary.org>
 <CAC-Np1yn6i=FDM16rxOX8ZjXVj=u6GatC0u2tg8w9YHRvKZ9dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50816 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbdAFONa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 6 Jan 2017 09:13:30 -0500
In-Reply-To: <CAC-Np1yn6i=FDM16rxOX8ZjXVj=u6GatC0u2tg8w9YHRvKZ9dw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, Yuri Weinstein <yweinste@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

> The way to test this would be to create a cluster with monitors that
> can't form a quorum. For example, with 2 monitors or by giving
> bad short hostnames in the configuration. The test would need to
> verify that it doesn't hang forever, it just fails after 10 minutes.

Can you help with that?

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
