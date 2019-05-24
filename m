From: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
Subject: Re: RFC: relicence Ceph LGPL-2.1 code as LGPL-2.1 or
 LGPL-3.0
Date: Fri, 24 May 2019 14:37:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1905162245580.24518@piezo.novalocal>
References: <alpine.DEB.2.11.1904221623540.7135@piezo.novalocal>
 <robbat2-20190510T200848-729932465Z@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <robbat2-20190510T200848-729932465Z-UgNl/1uUEYUufQK+DwRw3KxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Robin H. Johnson" <robbat2-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Fri, 10 May 2019, Robin H. Johnson wrote:
> On Fri, May 10, 2019 at 02:27:11PM +0000, Sage Weil wrote:
> > If you are a Ceph developer who has contributed code to Ceph and object to 
> > this change of license, please let us know, either by replying to this 
> > message or by commenting on that pull request.
> Am I correct in reading the diff that only a very small number of files
> did not already have the 'or later' clause of *GPL in effect?

To the contrary, I think one file (the COPYING file) has one line as a 
catch-all for everything (that isn't a special case) which is changing 
from 2.1 to 2.1 or 3.

https://github.com/ceph/ceph/pull/22446/files#diff-7116ef0705885343c9e1b2171a06be0eR6

> As a slight tangent, can we get SPDX tags on files rather than this
> hard-to-parse text?

(/me googles SPDX)

Sure?  The current format is based on the Debian copyright file format, 
which seemed appropriate at the time.  Happy to take patches that add more 
appropriate annotations...

sage
