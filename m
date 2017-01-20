From: Joao Eduardo Luis <joao-l3A5Bk7waGM@public.gmane.org>
Subject: Re: Question about user's key
Date: Fri, 20 Jan 2017 13:53:00 +0000
Message-ID: <93b499a8-4c91-b860-1219-02d3d4f0e8cc@suse.de>
References: <C5A0092C63E939488005F15F736A81125B261330@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <C5A0092C63E939488005F15F736A81125B261330-0J0gbvR4kTg/UvCtAeCM4rfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: "Chen, Wei D" <wei.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ceph-User <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

On 01/20/2017 03:52 AM, Chen, Wei D wrote:
> Hi,
>
> I have read through some documents about authentication and user management about ceph, everything works fine with me, I can create
> a user and play with the keys and caps of that user. But I cannot find where those keys or capabilities stored, obviously, I can
> export those info to a file but where are they if I don't export them out?
>
> Looks like these information (keys and caps) of the user is stored in memory? but I still can list them out after rebooting my
> machine. Or these info are persisted in some type of DB I didn't aware?
>
> Can anyone help me out?

Authentication keys and caps are kept by the monitor in its store, 
either a leveldb or a rocksdb, in its data directory.

The monitor's data directory are, by default, in 
/var/lib/ceph/mon/ceph-X, with X being the monitor's id. The store is 
within that directory, named `store.db`.

The store in not in human-readable format, but you can use 
ceph-kvstore-tool to walk the keys if you want. Please note that, should 
you want to do this, the monitor must be shutdown first.

   -Joao
