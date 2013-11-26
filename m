From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: Re: os recommendations
Date: Tue, 26 Nov 2013 06:50:33 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311260647310.24677@cobra.newdream.net>
References: <CAMNMNTz+whZWk55qCxx_8JCRWAruoHYz+stHYS93gBiU3qz3SQ@mail.gmail.com>
	<20131126142243.GA7360@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <20131126142243.GA7360-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On Tue, 26 Nov 2013, Christoph Hellwig wrote:
> On Tue, Nov 26, 2013 at 11:43:07AM +0100, Dominik Mostowiec wrote:
> > Hi,
> > I found in doc: http://ceph.com/docs/master/start/os-recommendations/
> > "Putting multiple ceph-osd daemons using XFS or ext4 on the same host
> > will not perform as well as they could."
> > 
> > For now recommended filesystem is XFS.
> > This means that for the best performance setup should be 1 OSD per host?
> 
> Btw, could anyone clarify where that stance comes from, that is numbers
> to back it up.

If syncfs(2) is not present, we have to use sync(2).  That means you have 
N daemons calling sync(2) to force a commit on a single fs, but all other 
mounted fs's are also synced... which means N times the sync(2) calls.

Fortunately syncfs(2) has been around for a while now, so this only 
affects really old distros.  And even when glibc does not have a syscall 
wrapper for it, we try to call the syscall directly.

sage
