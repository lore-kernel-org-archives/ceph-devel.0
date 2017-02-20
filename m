From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: UID/GID for ceph user and group
Date: Mon, 20 Feb 2017 22:15:06 +0100
Message-ID: <ea16c75d-28cd-565d-b831-090fe323ea87@suse.cz>
References: <24f3a600-fe0f-05ba-7404-f30db486a9e1@digiware.nl>
 <CAF-wwdEQckkwGu1ooUeAv70DwP9Vm0+kOzwUVLEsbp14ubL0Xg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58328 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750893AbdBTVds (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 20 Feb 2017 16:33:48 -0500
In-Reply-To: <CAF-wwdEQckkwGu1ooUeAv70DwP9Vm0+kOzwUVLEsbp14ubL0Xg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brad Hubbard <bhubbard@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Brad:

> https://github.com/ceph/ceph/blob/master/ceph.spec.in#L970
>
> I wonder if that should be "%if 0%{?rhel} || 0%{?fedora} || 0%{?centos}" ?
>
> Seems odd you'd be the first to notice though?????

No, because 0%{?rhel} evaluates to true on CentOS.

Regards.
Nathan
