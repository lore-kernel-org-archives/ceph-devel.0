From: Gregory Farnum <greg-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: About ceph testing
Date: Wed, 18 Sep 2013 10:57:53 -0700
Message-ID: <CAPYLRzgXYWEuToCDmShGuVJHFxwpLvzQbbR2VnOC08Eamtz1NA@mail.gmail.com>
References: <CAGkCoNJQFM1-7o8XR_d7eUXYjjwXQhgEK5GWNUMwyAzN7u03Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <CAGkCoNJQFM1-7o8XR_d7eUXYjjwXQhgEK5GWNUMwyAzN7u03Uw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: david zhang <zhang.david2011-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Loic Dachary <loic-cLsNCMjd+0JAfugRpC6u6w@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, Sep 17, 2013 at 10:07 PM, david zhang <zhang.david2011-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi ceph-users,
>
> Previously I sent one mail to ask for help on ceph unit test and function
> test. Thanks to one of your guys, I got replied about unit test.
>
> Since we are planning to use ceph, but with strict quality bar inside, we
> have to evaluate and test the major features we want to use by ourselves. In
> order to avoid reduplicated work and accelerate ceph adaption, could you
> please share us any information about ceph testing, such as test strategy,
> test plan, function & performance test, etc?
>
> Looking forward to your reply. Thanks so much.

You'll want to investigate our teuthology framework and the qa suites
we've set up (https://github.com/ceph/teuthology,
https://github.com/ceph/ceph-qa-suite), as well as the qa subdirectory
of the main Ceph repo. Loic and a few other users on the dev list have
gotten involved with this and I believe he's trying to set up meetings
and info sessions for Inktank-external people to help make teuthology
more usable.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
