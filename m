From: Dominik Mostowiec <dominikmostowiec-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ceph s3 allowed characters
Date: Fri, 30 Aug 2013 15:52:11 +0200
Message-ID: <CAMNMNTxn3DCbVAnvY1K7PE7Z1oWy-4nM_XKT92+xYEBxKzd=Yg@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hi,
I got err (400) from radosgw on request:
2013-08-30 08:09:19.396812 7f3b307c0700  2 req 3070:0.000150::POST
/dysk/files/test.test%40op.pl/DOMIWENT%202013/DW%202013_03_27/PROJEKTY%202012/ZB%20KROL/Szko%C5%82a%20%C5%81aziska%20ZB%20KROL/sala-%A3aziska_Dolne_PB-0_went_15_11_06%20Layout1%20%283%29.pdf::http
status=400
2013-08-30 08:09:34.851892 7f3b55ffb700 10
s->object=files/test.test-FWhLrETftxM@public.gmane.org/DOMIWENT 2013/Damian
DW/dw/Specyfikacja istotnych warunk<F3>w zam<F3>wienia.doc
s->bucket=dysk

What is allowed range of chars in url in radosgw?

-- 
Regards
Dominik
