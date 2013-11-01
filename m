From: Alfredo Deza <alfredo.deza-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: [ANN] ceph-deploy 1.3 released!
Date: Fri, 1 Nov 2013 08:54:13 -0400
Message-ID: <CANtztVz+=1DawR-it8t_9WSkxALzMvrXA6SxoomD9x9N-hztgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi all,

A new version (1.3) of ceph-deploy is now out, a lot of fixes went
into this release including the addition of a more robust library to
connect to remote hosts and it removed the one extra dependency we
used. Installation should be simpler.

The complete changelog can be found at:

https://github.com/ceph/ceph-deploy/blob/master/docs/source/changelog.rst


The highlights for this release are:


* We now allow to use `--username` to connect on remote hosts,
specifying something different than the current user or the SSH
config.

* Global timeouts for remote commands to be able to disconnect if
there is no input received (defaults to 5 minutes), but still allowing
other more granular timeouts for some commands that need to just run a
simple command without output expectation.


Please make sure you update (install instructions:
http://github.com/ceph/ceph-deploy/#installation) and use the latest
version!


Thanks,


Alfredo
