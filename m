From: Guang Yang <yguang11-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
Subject: OSD disk replacement best practise
Date: Thu, 14 Aug 2014 19:29:45 +0800
Message-ID: <BLU436-SMTP13190B33FCDD9EB1BD24DCEDFE80@phx.gbl>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
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
To: Ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi cephers,
Most recently I am drafting the run books for OSD disk replacement, I think the rule of thumb is to reduce data migration (recover/backfill), and I thought the following procedure should achieve the purpose:
  1. ceph osd out osd.XXX (mark it out to trigger data migration)
  2. ceph osd rm osd.XXX
  3. ceph auth rm osd.XXX
  4. provision a new OSD which will take XXX as the OSD id and migrate data back.

With the above procedure, the crush weight of the host never changed so that we can limit the data migration only for those which are neccesary.

Does it make sense?

Thanks,
Guang
