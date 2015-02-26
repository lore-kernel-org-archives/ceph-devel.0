From: John Spray <john.spray@redhat.com>
Subject: Re: MDS crashes (80.8)
Date: Thu, 26 Feb 2015 17:06:03 +0000
Message-ID: <54EF527B.8060403@redhat.com>
References: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55757 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932100AbbBZRGG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 26 Feb 2015 12:06:06 -0500
In-Reply-To: <CAGbvivJQYb6KpZPW0ug_q7rbL_NYB2eGS+Vcktvy_W3ECHxKbA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, ceph-devel@vger.kernel.org

On 26/02/2015 15:26, Wyllys Ingersoll wrote:
> Trying to run ceph-mds on a freshly installed firefly cluster with no
> ceph FS created yet.
>
> It consistently crashes upon startup. Below is debug output showing
> the point of the crash.   Something is obviously misconfigured or
> broken but Im at a loss as to where the issue would be. Any ideas?
The MDS thinks that its on-disk tables should already exist (the MDSMap 
structure on the mons are telling it so), but when it goes to read them 
from RADOS it's finding that they aren't there.

This is reminiscent of http://tracker.ceph.com/issues/7485, although I 
just checked and the v0.80.8 tag does include the fix for that. Please 
could you see if you have the MDS log from the very first time it ran?  
There is probably a clue there.

Once you have recovered that and any other interesting diagnostic 
information, you can try to get out of this bad state by using "ceph mds 
newfs" to reset the MDSMap.

Thanks,
John
