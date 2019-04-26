From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: RGW Beast frontend and ipv6 options
Date: Fri, 26 Apr 2019 10:49:58 +0200
Message-ID: <87a7gdgngp.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
 <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


Currently RGW's beast frontend supports ipv6 via the endpoint
configurable. The port option will bind to ipv4 _only_.

http://docs.ceph.com/docs/master/radosgw/frontends/#options

Since many Linux systems may default the sysconfig net.ipv6.bindv6only
flag to true, it usually means that specifying a v6 endpoint will bind
to both v4 and v6. But this also means that deployment systems must be
aware of this while configuring depending on whether both v4 and v6
endpoints need to work or not. Specifying both a v4 and v6 endpoint or a
port (v4) and endpoint with the same v6 port will currently lead to a
failure as the system would've already bound the v6 port to both v4 and
v6. This leaves us with a few options.

1. Keep the implicit behaviour as it is, document this, as systems are
already aware of sysconfig flags and will expect that at a v6 endpoint
will bind to both v4 and v6.

2. Be explicit with endpoints & configuration, Beast itself overrides
the socket option to bind both v4 and v6, which means that v6 endpoint
will bind to v6 *only* and binding to a v4 will need an explicit
specification. (there is a pr in progress for this:
https://github.com/ceph/ceph/pull/27270)

Any more suggestions on how systems handle this are also welcome.

--
Abhishek 
