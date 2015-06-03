From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: packaging init systems in a more autoools style way.
Date: Wed, 03 Jun 2015 15:40:50 -0600
Message-ID: <556F7462.3050907@redhat.com>
References: <556F1E19.6080704@suse.com> <alpine.DEB.2.00.1506030919460.9814@cobra.newdream.net> <556F6480.1090901@suse.com> <alpine.DEB.2.00.1506031344370.26591@cobra.newdream.net> <556F7344.4030003@redhat.com> <alpine.DEB.2.00.1506031438210.26591@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49867 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751298AbbFCVkv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 3 Jun 2015 17:40:51 -0400
In-Reply-To: <alpine.DEB.2.00.1506031438210.26591@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

On 06/03/2015 03:38 PM, Sage Weil wrote:
> On Wed, 3 Jun 2015, Ken Dreyer wrote:
>> On 06/03/2015 02:45 PM, Sage Weil wrote:
>>> Sounds good to me.  It could (should?) even error out if no init
>> system is
>>> specified?  Otherwise someone will likely be in for a surprise.
>>
>> I was picturing that we'd just autodetect based on OS version (eg Ubuntu
>> 15.04 should default to --with-init=systemd). It's one less thing to get
>> wrong during the build process.
>>
>> What do you think?
> 
> ./configure ... --with-init=`src/ceph-detect-init` ?
> 
> sage
> 

I should have been clearer. I was thinking that we'd call that
detect-init script inside ./configure itself , unless the user specifies
--with-init=foo .

- Ken
