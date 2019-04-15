From: M Ranga Swami Reddy <swamireddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: HW failure cause client IO drops
Date: Mon, 15 Apr 2019 18:38:42 +0530
Message-ID: <CANA9Uk7rGa53ZgYTx4shvyEbgBgOk2_mySDzz-TB4qkQPC7VbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5444323715054297253=="
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
To: ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sage Weil <sage-BnTBU8nroG7k1uMJSBkQmQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============5444323715054297253==
Content-Type: multipart/alternative; boundary="000000000000a995470586915aa0"

--000000000000a995470586915aa0
Content-Type: text/plain; charset="UTF-8"

Hello - Recevenlt we had an issue with storage node's battery failure,
which cause ceph client IO dropped to '0' bytes. Means ceph cluster
couldn't perform IO operations on the cluster till the node takes out. This
is not expected from Ceph, as some HW fails, those respective OSDs should
mark as out/down and IO should go as is..

Please let me know if anyone seen the similar behavior and is this issue
resolved?

Thanks
Swami

--000000000000a995470586915aa0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello - Recevenlt we had an issue with storage node&#39;s =
battery failure, which cause ceph=C2=A0client IO dropped to &#39;0&#39; byt=
es. Means ceph=C2=A0cluster couldn&#39;t perform IO operations on the clust=
er till the node takes out. This is not expected from Ceph, as some HW fail=
s, those respective OSDs should mark as out/down and IO should go as is..<d=
iv><br></div><div>Please let me know if anyone seen the similar behavior an=
d is this issue resolved?</div><div><br></div><div>Thanks</div><div>Swami</=
div></div>

--000000000000a995470586915aa0--

--===============5444323715054297253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============5444323715054297253==--
