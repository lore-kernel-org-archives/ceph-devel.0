From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: Backporting stability fixes for ceph-disk
Date: Wed, 3 Feb 2016 20:13:03 -0700
Message-ID: <CALqRxCwsz5527AFZw9sPT+W0fW66p58iToz_x7Syc8H1C38O_w@mail.gmail.com>
References: <56B04476.5020203@redhat.com>
	<CALqRxCyTk5NPQJE7PTX4txbCPB2eagMBvH+V9HLHXkir4hij4g@mail.gmail.com>
	<56B2509A.6090709@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:34282 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbcBDDNF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 22:13:05 -0500
Received: by mail-wm0-f41.google.com with SMTP id 128so7506203wmz.1
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 19:13:04 -0800 (PST)
In-Reply-To: <56B2509A.6090709@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Feb 3, 2016 at 12:10 PM, Loic Dachary <loic@dachary.org> wrote:
> On 04/02/2016 00:56, Ken Dreyer wrote:
>> What's the procedure for deactivating the Hammer udev rules, for example?
>
> rm /lib/udev/rules.d/*ceph*
> udevadm control --reload # maybe superfluous
>

I am surprised to see that we'd want to delete files from /lib. How
would the user restore them afterwards? Sorry if this sounds dense;
I'm definitely a udev noob. Could you provide a "starting from
scratch" procedure for how to handle ceph-disk failures in Hammer?

- Ken
