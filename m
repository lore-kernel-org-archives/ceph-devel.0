From: Wido den Hollander <wido@42on.com>
Subject: Re: Would it make sense to require ntp
Date: Fri, 6 Nov 2015 12:36:36 +0100
Message-ID: <563C90C4.6090202@42on.com>
References: <563C7BB1.7030500@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:43963 "EHLO
	smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161397AbbKFLgn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Nov 2015 06:36:43 -0500
In-Reply-To: <563C7BB1.7030500@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, ceph-devel <ceph-devel@vger.kernel.org>

On 11/06/2015 11:06 AM, Nathan Cutler wrote:
> Hi Ceph:
> 
> Recently I encountered some a "clock skew" issue with 0.94.3. I have
> some small demo clusters in AWS. When I boot them up, in most cases the
> cluster will start in HEALTH_WARN due to clock skew on some of the MONs.
> 
> I surmise that this is due to a race condition between the ceph-mon and
> ntpd systemd services. Sometimes ntpd.service starts *after* ceph-mon -
> in this case the MON sees a wrong/unsynchronized time value.
> 
> Now, even though ntpd.service starts (and fixes the time value) very
> soon afterwards, the cluster remains in clock skew for a long time - but
> that is a separate issue. What I would like to ask is this:
> 
> Is there any reasonable Ceph cluster node configuration that does not
> include running the NTP daemon?
> 

Well, the MONs are very, very time sensitive. OSDs somewhat less, but if
they drift too far they run into trouble authenticating.

> If the answer is "no", would it make sense to make NTP a runtime
> dependency and tell the ceph-mon systemd service to wait for
> ntpd.service before it starts?
> 

I think it makes sense, correct time is essential imho.

> Thanks and regards
> 


-- 
Wido den Hollander
42on B.V.
Ceph trainer and consultant

Phone: +31 (0)20 700 9902
Skype: contact42on
