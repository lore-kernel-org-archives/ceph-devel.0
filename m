From: Alex Bligh <alex@alex.org.uk>
Subject: Re: [PATCH v3 2/2] rbd: link and load librbd
 dynamically
Date: Fri, 21 Jun 2013 20:08:31 +0100
Message-ID: <4786AD87B0A2E9AAE51398B6@nimrod.local>
References: <20130405093124.GA2351@dhcp-200-207.str.redhat.com>
	<1365552342-22840-1-git-send-email-josh.durgin@inktank.com>
	<CAJSP0QWy1CUOX+BVB2kfXfRpcdPuwbywZ3tReo83zK23+B4vbQ@mail.gmail.com>
	<87ip3uctjv.fsf@codemonkey.ws>
	<alpine.DEB.2.00.1306211138310.454@cobra.newdream.net>
Reply-To: Alex Bligh <alex@alex.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
In-Reply-To: <alpine.DEB.2.00.1306211138310.454@cobra.newdream.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Sage Weil <sage@inktank.com>, Anthony Liguori <anthony@codemonkey.ws>
Cc: Kevin Wolf <kwolf@redhat.com>, Alex Bligh <alex@alex.org.uk>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Josh Durgin <josh.durgin@inktank.com>, Paolo Bonzini <pbonzini@redhat.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org



--On 21 June 2013 11:42:34 -0700 Sage Weil <sage@inktank.com> wrote:

> Has any progress been made toward a generic dynamic linking solution for
> block drivers?  It is a conceptually simple change, but non-trivial for
> anyone unfamiliar with the build system.
>
> In the mean time, the inability to dynamically link librbd is continuing
> to cause significant pain for distro users.  Would you consider merging
> the rbd-specific linking as an interim solution until something is
> generically available to qemu?

FWIW I have this implemented here:
 https://github.com/flexiant/qemu/commits/v1.0-rbd-add-async-flush

specifically this commit:
 https://github.com/flexiant/qemu/commit/6fa2e9c95bdaca7c814881e27f04424fb6cc
2960

This is a backport of qemu 1.5's librbd to qemu 1.0 (which is slighly
confusing) but the #pragma weak technique is basically the same.

I had to use a slightly different technique to Josh's original version
to get it to compile with old includes and still run with a new
library, as well as vice versa.

It would take me only a few minutes to bring this back as a patch for
1.5 if anyone is interested. I assumed they would not be.

-- 
Alex Bligh
