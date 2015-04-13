From: John Spray <john.spray@redhat.com>
Subject: Re: negative pool stats (was: Bug?)
Date: Mon, 13 Apr 2015 12:36:16 +0100
Message-ID: <552BAA30.4090305@redhat.com>
References: <CAMzumdaqedD8ANCESRLE44rsA0McwJA32VghpGzDYNgSw4bSqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39319 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932084AbbDMLgR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 07:36:17 -0400
In-Reply-To: <CAMzumdaqedD8ANCESRLE44rsA0McwJA32VghpGzDYNgSw4bSqg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Barclay Jameson <almightybeeij@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 10/04/2015 19:27, Barclay Jameson wrote:
> Watching osd pool stats (watch --interval=.5 -d 'ceph osd pool stats')
> while restarting 1/3 of my OSDs give some odd numbers:
>
> pool cephfs_data id 1
>    -768/9 objects degraded (-8533.333%)
>    recovery io 18846 B/s, 1 objects/s
>    client io 15356 B/s wr, 2 op/s
>
> pool cephfs_metadata id 2
>    -1/0 objects degraded (-inf%)
>

Negative stats are: http://tracker.ceph.com/issues/7737

The fix appears to have just missed 0.94, but should be in the next 
stable releases.

John
