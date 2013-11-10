From: Malcolm Haak <malcolm@sgi.com>
Subject: Re: HSM
Date: Mon, 11 Nov 2013 09:17:07 +1000
Message-ID: <528013F3.1010300@sgi.com>
References: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.179.30]:58398 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752306Ab3KJXRL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 10 Nov 2013 18:17:11 -0500
In-Reply-To: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Hi All,

If you are talking specifically about Lustre HSM, its really an 
interface to add HSM functionality by leveraging existing HSM's (DMF for 
example)

So with Lustre HSM you have a policy engine that triggers the migrations 
out of the filesystem. Rules are based around size, last accessed and 
target state (online, dual and offline).

There is a 'coordinator' process involved here as well, it (from what I 
understand) runs on MDS nodes. It handles the interaction with the 
copytool. The copytool is provided by the HSM solution you are acutally 
using.

For recalls when caps are aquired on the MDS for an exported file the 
resposible MSD contacts the coordinator, which in-turn uses the copytool 
to pull the required file out of the HSM.

In the Lustre HSM, the objects that make up a file are all recalled and 
the file, not the objects, are handed to the HSM.

For Lustre all it needs to keep track of is the current state of the 
file and the correct ID to reqest from the HSM. This is done inside the 
normal metadata storage.

So there aren't really any hooks in that exports are triggered by the 
policy engine after a scan of the metadata, and the recalls are 
triggered when caps are requested on offline files. Then its just 
standard POSIX blocking until the file is available.

Most of the state and ID stuff could be stored as XATTRS in cephfs. I'm 
not as sure how to do it for other things but as long as you could store 
some kind of extended metadata about whole objects, it could use the 
same interfaces as well.

Hope that was acutually helpful and not just an obvious rehash...

Regards

Malcolm Haak

On 09/11/13 18:33, Sage Weil wrote:
> The latest Lustre just added HSM support:
>
> 	http://archive.hpcwire.com/hpcwire/2013-11-06/lustre_scores_business_class_upgrade_with_hsm.html
>
> Here is a slide deck with some high-level detail:
> 	
> 	https://jira.hpdd.intel.com/secure/attachment/13185/Lustre_HSM_Design.pdf
>
> Is anyone familiar with the interfaces and requirements of the file system
> itself?  I don't know much about how these systems are implemented, but I
> would guess there are relatively lightweight requirements on the fs (ceph
> mds in our case) to keep track of file state (online or archived
> elsewhere).  And some hooks to trigger migrations?
>
> If anyone is interested in this area, I would be happy to help figure out
> how to integrate things cleanly!
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
