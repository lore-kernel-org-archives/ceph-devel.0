From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler-YTcQvvOqK21BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [Ceph-announce] Luminous v12.2.1 released
Date: Mon, 2 Oct 2017 14:10:45 +0200
Message-ID: <20171002121045.ydbzidb2cofdrzek@nora.maurer-it.com>
References: <1b8b25baf4d8e5c661bf56d50ee17aa5@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1b8b25baf4d8e5c661bf56d50ee17aa5-IBi9RG/b67k@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Abhishek <abhishek-IBi9RG/b67k@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

On Thu, Sep 28, 2017 at 05:46:30PM +0200, Abhishek wrote:
> This is the first bugfix release of Luminous v12.2.x long term stable
> release series. It contains a range of bug fixes and a few features
> across CephFS, RBD & RGW. We recommend all the users of 12.2.x series
> update.
> 
> For more details, refer to the release notes entry at the official
> blog[1] and the complete changelog[2]
> 
> Notable Changes
> ---------------
> 
> [ snip ]
> 
> * The maximum number of PGs per OSD before the monitor issues a
>    warning has been reduced from 300 to 200 PGs.  200 is still twice
>    the generally recommended target of 100 PGs per OSD.  This limit can
>    be adjusted via the ``mon_max_pg_per_osd`` option on the
>    monitors.  The older ``mon_pg_warn_max_per_osd`` option has been
> removed.
> 
> * Creating pools or adjusting pg_num will now fail if the change would
>    make the number of PGs per OSD exceed the configured
>    ``mon_max_pg_per_osd`` limit.  The option can be adjusted if it
>    is really necessary to create a pool with more PGs.
> 
> [ snip ]
> 
> Getting Ceph
> ------------
> 
> [ snip ]
> 
> [1]: http://ceph.com/releases/v12-2-1-luminous-released/
> [2]: https://github.com/ceph/ceph/blob/master/doc/changelog/v12.2.1.txt
> 

those release notes should be corrected, [1] did apparently not make the
cut for 12.2.1 but makes up 1/3 of the notable changes..

1: https://github.com/ceph/ceph/pull/17814
