From: Chris Dunlop <chris-s239Etu9j1dPR4JQBCEnsQ@public.gmane.org>
Subject: Re: All pgs stuck peering
Date: Tue, 15 Dec 2015 12:49:19 +1100
Message-ID: <20151215014918.GA17826@onthe.net.au>
References: <20151214025216.GA31989@onthe.net.au>
	<BLUPR0201MB1908978B52BB1EE6821EBC34E2ED0@BLUPR0201MB1908.namprd02.prod.outlook.com>
	<20151214040137.GA2197@onthe.net.au>
	<CAANLjFrbos6rQwjXwu9uXzFQVROHUPL_tDepTvwZ97r=zGcmZA@mail.gmail.com>
	<20151214041841.GA2925@onthe.net.au>
	<CAKZcxgdKFpUAp6VWDhNtrBKWJiSqothokwPj+8KEPM2F9Y_=nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKZcxgdKFpUAp6VWDhNtrBKWJiSqothokwPj+8KEPM2F9Y_=nw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jaze Lee <jazeltq-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Mon, Dec 14, 2015 at 09:29:20PM +0800, Jaze Lee wrote:
> Should we add big packet test in heartbeat? Right now the heartbeat
> only test the little packet. If the MTU is mismatched, the heartbeat
> can not find that.

It would certainly have saved me a great deal of stress!

I imagine you wouldn't want it doing a big packet test every
heartbeat, perhaps every 10th or some configurable number.

Something for the developers to consider? (cc'ed)

Chris
