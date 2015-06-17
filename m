From: Abhishek L <abhishek.lekshmanan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: xattrs vs. omap with radosgw
Date: Wed, 17 Jun 2015 14:55:26 +0530
Message-ID: <CAEw75dM7hMK3+Yn1UV=mideNHNHzLD2uOn6xaB=0sk4kBj5e7A@mail.gmail.com>
References: <BLU175-W13D5737A24429707F8F978DFA70@phx.gbl>
	<alpine.DEB.2.00.1506161241060.15556@cobra.newdream.net>
	<55812276.2040305@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <55812276.2040305-AlSwsSmVLrQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Nathan Cutler <ncutler-AlSwsSmVLrQ@public.gmane.org>
Cc: Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jun 17, 2015 at 1:02 PM, Nathan Cutler <ncutler-AlSwsSmVLrQ@public.gmane.org> wrote:
>> We've since merged something
>> that stripes over several small xattrs so that we can keep things inline,
>> but it hasn't been backported to hammer yet.  See
>> c6cdb4081e366f471b372102905a1192910ab2da.
>
> Hi Sage:
>
> You wrote "yet" - should we earmark it for hammer backport?
>
I'm guessing https://github.com/ceph/ceph/pull/4973 is the backport for hammer
(issue http://tracker.ceph.com/issues/11981)

Regards
Abhishek
