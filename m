From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: vi, multiple users
Date: Wed, 30 Dec 2009 11:56:21 -0800
Message-ID: <a37615150912301156w2cc0bb07l3035a2176f71d0cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4368330463400173602=="
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@lists.sourceforge.net>
List-Id: ceph-devel.vger.kernel.org

--===============4368330463400173602==
Content-Type: multipart/alternative; boundary=001636e1e9f35b2cbf047bf7885a

--001636e1e9f35b2cbf047bf7885a
Content-Type: text/plain; charset=ISO-8859-1

There still is a problem with vi and multiple users. E.g., the following
scenario fails:

client1: cd /mnt; cp ~/foo .
client2: head foo
client1: vi foo; <change something, write, exit>
client2: head foo

now foo appears to be corrupted.

I guess it is likely that is still related to the truncation reporting that
was found yesterday, I'll try to verify that.

Yehuda

--001636e1e9f35b2cbf047bf7885a
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr">There still is a problem with vi and multiple users. E.g., the following scenario fails:<div><br></div><div>client1: cd /mnt; cp ~/foo .</div><div>client2: head foo</div><div>client1: vi foo; &lt;change something, write, exit&gt;</div>
<div>client2: head foo</div><div><br></div><div>now foo appears to be corrupted.</div><div><br></div><div>I guess it is likely that is still related to the truncation reporting that was found yesterday, I&#39;ll try to verify that.</div>
<div><br></div><div>Yehuda</div></div>

--001636e1e9f35b2cbf047bf7885a--


--===============4368330463400173602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--===============4368330463400173602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--===============4368330463400173602==--
