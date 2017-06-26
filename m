From: Nathan Cutler <ncutler@suse.cz>
Subject: Re: Are we ready for 10.2.8 - rgw
Date: Mon, 26 Jun 2017 18:37:30 +0200
Message-ID: <9bcd5e40-5a0f-b565-b60c-fbedd010bef7@suse.cz>
References: <ef00f025-27ea-6efa-80db-2ebb15d5b819@suse.cz>
 <CADRKj5T_B0Rsva7--OnNehV3-8tYYRfv_V=rAOc-pyWZh7MycA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54463 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751440AbdFZQhc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 26 Jun 2017 12:37:32 -0400
In-Reply-To: <CADRKj5T_B0Rsva7--OnNehV3-8tYYRfv_V=rAOc-pyWZh7MycA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Orit Wasserman <owasserm@redhat.com>

On 06/12/2017 08:59 PM, Yehuda Sadeh-Weinraub wrote:
> I think so. I do see a large list of issues  with backport set to
> jewel. Some of these were already backported but we didn't resolve the
> tracker. I think that we can probably cut 10.2.8 now, and maybe plan
> on early 10.2.9?

Orit asked for:

http://tracker.ceph.com/issues/19876
http://tracker.ceph.com/issues/19757

and both have been merged. I went through the rgw issues in the jewel 
backport tracker and indeed some were not marked resolved - now fixed. 
But there are many still open. I would like to get 10.2.9 out the door 
early-ish, yes, but I was hoping that for 10.2.8 as well. . .

So, do you think it's time for QE to do its testing?

Nathan
