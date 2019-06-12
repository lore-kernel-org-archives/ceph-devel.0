From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: RFC: relicence Ceph LGPL-2.1 code as LGPL-2.1 or
 LGPL-3.0
Date: Wed, 12 Jun 2019 14:50:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1906121446570.4977@piezo.novalocal>
References: <alpine.DEB.2.11.1904221623540.7135@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1904221623540.7135-qHenpvqtifaMSRpgCs4c+g@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 10 May 2019, Sage Weil wrote:
> Hi everyone,
> 
> -- What --
> 
> The Ceph Leadership Team[1] is proposing a change of license from 
> *LGPL-2.1* to *LGPL-2.1 or LGPL-3.0* (dual license). The specific changes 
> are described by this pull request:
> 
> 	https://github.com/ceph/ceph/pull/22446
> 
> If you are a Ceph developer who has contributed code to Ceph and object to 
> this change of license, please let us know, either by replying to this 
> message or by commenting on that pull request.
> 
> Our plan is to leave the issue open for comment for some period of time 
> and, if no objections are raised that cannot be adequately addressed (via 
> persuasion, code replacement, or whatever) we will move forward with the 
> change.

We've heard no concerns about this change, so I just merged the pull 
request.  Thank you, everyone!


Robin suggested that we also add SPDX tags to all files.  IIUC those look 
like this:

 // SPDX-License-Identifier: LGPL-2.1 or LGPL-3.0

This sounds like a fine idea.  Any takers?  Note that this can't replace 
the COPYING and debian/copyright files, that latter of which at least 
is needed by Debian.  But additional and explicit license notifications 
in each file sounds like a good thing.

Thanks!
sage
