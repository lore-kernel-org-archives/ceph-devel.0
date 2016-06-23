From: Blair Bethwaite <blair.bethwaite-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Dramatic performance drop at certain number of
 objects in pool
Date: Thu, 23 Jun 2016 12:55:17 +1000
Message-ID: <CA+z5DszcLqV32NnWeuu+WsRZoZwM493Jfy7WcSpVtaDyArwFAQ@mail.gmail.com>
References: <CA+e22ScW-YrDE0mPABSuiDbDpKL=gYZXv6t2hK8RJxYuMaVLHg@mail.gmail.com>
	<1450235390.2134.1466084299677@ox.pcextreme.nl>
	<CA+z5DszqHuevkAF3W01R=7AAeqVcyuHZTX0+bAvThgihvOjwuA@mail.gmail.com>
	<CA+z5Dsy4tbyiL71C8CQCTQ66tY1=9thSWdNA4BSn6=tNfGUE6w@mail.gmail.com>
	<CA+e22Sc3iY5Lvp4oGwJ_wwpJsOJsWdB1thaHWEAuYP=bbGHAeg@mail.gmail.com>
	<D38DCB57.131AE%warren.wang@walmart.com>
	<20160621075856.3ad471d1@batzmaru.gol.ad.jp>
	<CA+e22SdrwRHmAD=67MpVtUXVyCOmidcoUXrANZVeDJc2tcJfnQ@mail.gmail.com>
	<CA+z5Dswx7V_HsiQ8TyhXmzJ70-D6kTQrfi8am7wMZOJVzsLerw@mail.gmail.com>
	<20160623113717.446a1f9d@batzmaru.gol.ad.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20160623113717.446a1f9d-9yhXNL7Kh0lSCLKNlHTxZM8NsWr+9BEh@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org>
Cc: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 23 June 2016 at 12:37, Christian Balzer <chibi-FW+hd8ioUD0@public.gmane.org> wrote:
> Case in point, my main cluster (RBD images only) with 18 5+TB OSDs on 3
> servers (64GB RAM each) has 1.8 million 4MB RBD objects using about 7% of
> the available space.
> Don't think I could hit this problem before running out of space.

Perhaps. However ~30TB per server is pretty low with present HDD
sizes. In the pool on our large cluster where we've seen this issue we
have 24x 4TB OSDs per server, and we first hit the problem in pre-prod
testing at about 20% usage (with default 4MB objects). We went to 40 /
8. Then as I reported the other day we hit the issue again at
somewhere around 50% usage. Now we're at 50 / 12.

The boxes mentioned above are a couple of years old. Today we're
buying 2RU servers with 128TB in them (16x 8TB)!

Replacing our current NAS on RBD setup with CephFS is now starting to
scare me...

-- 
Cheers,
~Blairo
