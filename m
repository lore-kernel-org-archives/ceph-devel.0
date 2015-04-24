From: Ken Dreyer <kdreyer@redhat.com>
Subject: Re: running daemons as user/group ceph
Date: Fri, 24 Apr 2015 16:30:54 -0600
Message-ID: <553AC41E.80100@redhat.com>
References: <alpine.DEB.2.00.1504241037370.5458@cobra.newdream.net> <553AAFFB.4070808@redhat.com> <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45818 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966964AbbDXWa4 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 24 Apr 2015 18:30:56 -0400
In-Reply-To: <alpine.DEB.2.00.1504241411440.5458@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: danny.al-gaaf@bisect.de, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com

On 04/24/2015 03:13 PM, Sage Weil wrote:
> On Fri, 24 Apr 2015, Ken Dreyer wrote:
>> On 04/24/2015 11:37 AM, Sage Weil wrote:
>>> -- Logs --
>>>
>>
>> One other thing in addition to the log directory is the socket directory
>> permissions (/var/run/ceph). The ceph UID will need to write there, right?
>>
>> In newer distros with systemd, /var/run is on tmpfs so we use this
>> tmpfiles.d snippet to be sure the directory is there in /var/tmpfs after
>> every boot:
>>
>> https://github.com/ceph/ceph/blob/master/systemd/ceph.tmpfiles.d
>>
>> The snippet currently creates the directory as root-owned, and I imagine
>> we'd want to change that to the ceph UID instead?
> 
> Yeah, I changed that file.  Again, not certain about the group permissions 
> bit, though.

Oh, my bad, sorry I missed that part of the pull request! Looks good to me.

- Ken
