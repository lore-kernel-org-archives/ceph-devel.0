From: David Disseldorp <ddiss@suse.de>
Subject: Re: udev remove events to mark OSD down/out on disk-pull
Date: Wed, 16 Nov 2016 13:57:11 +0100
Message-ID: <20161116135711.1ee0364b@suse.de>
References: <20161116033042.68eee001@suse.de>
        <a7537544-798b-bdbe-866c-eae740b4d53b@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58249 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751464AbcKPM5N (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 16 Nov 2016 07:57:13 -0500
In-Reply-To: <a7537544-798b-bdbe-866c-eae740b4d53b@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 16 Nov 2016 08:05:42 +0100, Loic Dachary wrote:

> How would you distinguish a udev remove occuring because the disk was pulled from a udev remove occuring because partprobe was run by a user / utility program ?

That could be detected based on whether the corresponding disk (backing
the partition) is still around, although that may complicate things if
the order of the udev events changes.

Cheers, David
