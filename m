From: Mykola Golub <to.my.trociny-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: RBD image format v1 EOL ...
Date: Wed, 20 Feb 2019 17:38:02 +0200
Message-ID: <20190220153758.GA10288@gmail.com>
References: <CA+aFP1Dod_hwug_omfegFTERyiYmwa+3KDcBZsXcjR+B87YykQ@mail.gmail.com>
 <20190220092247.GZ92783@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190220092247.GZ92783-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Cc: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Feb 20, 2019 at 10:22:47AM +0100, Jan Kasprzak wrote:

> 	If I read the parallel thread about pool migration in ceph-users@
> correctly, the ability to migrate to v2 would still require to stop the client
> before the "rbd migration prepare" can be executed.

Note, if even rbd supported live (without any downtime) migration you
would still need to restart the client after the upgrate to a new
librbd with migration support.

So actually you can combine the upgrade with migration:

  upgrade client library
  stop client
  rbd migration prepare
  start client

and eventually:

  rbd migration execute
  rbd migration commit

And it would be interesting to investigate a possibility to replace
"stop/start client" steps with "migrating the VM to another (upgraded)
host" to avoid stopping the VM at all. The trick would be to execute
somehow "rbd migration prepare" after the the sourse VM closes the
image, but before the destination VM opens it.

-- 
Mykola Golub
