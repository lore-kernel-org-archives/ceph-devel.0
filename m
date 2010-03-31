From: Cheng Renquan <crquan@gmail.com>
Subject: Re: [OLD ceph-devel] [PATCH] ceph: use ceph_sb_to_client instead of
	ceph_client
Date: Wed, 31 Mar 2010 17:20:33 +0800
Message-ID: <u2i91b13c311003310220w147f1d16k5979189b93d9029a@mail.gmail.com>
References: <1269596433-4483-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1269596433-4483-1-git-send-email-crquan@gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

T24gRnJpLCBNYXIgMjYsIDIwMTAgYXQgNTo0MCBQTSwgQ2hlbmcgUmVucXVhbiA8Y3JxdWFuQGdt
YWlsLmNvbT4gd3JvdGU6Cj4gY2VwaF9zYl90b19jbGllbnQgYW5kIGNlcGhfY2xpZW50IGFyZSBy
ZWFsbHkgaWRlbnRpY2FsLCB3ZSBuZWVkIHRvIGR1bXAKPiBvbmU7IHdoaWxlIGZ1bmN0aW9uIGNl
cGhfY2xpZW50IGlzIGNvbmZ1c2luZyB3aXRoICJzdHJ1Y3QgY2VwaF9jbGllbnQiLAo+IGNlcGhf
c2JfdG9fY2xpZW50J3MgZGVmaW5pdGlvbiBpcyBtb3JlIGNsZWFyOyBzbyB3ZSdkIGJldHRlciBz
d2l0Y2ggYWxsCj4gY2FsbCB0byBjZXBoX3NiX3RvX2NsaWVudC4KCk5vIGV4cGxpY2l0IGFwcHJv
dmFsIG9yIHJlamVjdD8gV2hhdCdzIHlvdXIgY29tbWVudCBvbiB0aGlzIHBhdGNoPwoKVGhhbmtz
LAoKLS0gCkNoZW5nIFJlbnF1YW4gKOeoi+S7u+WFqCksIGZyb20gU2luZ2Fwb3JlCgotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KRG93bmxvYWQgSW50ZWwmIzE3NDsgUGFyYWxsZWwgU3R1ZGlvIEV2YWwK
VHJ5IHRoZSBuZXcgc29mdHdhcmUgdG9vbHMgZm9yIHlvdXJzZWxmLiBTcGVlZCBjb21waWxpbmcs
IGZpbmQgYnVncwpwcm9hY3RpdmVseSwgYW5kIGZpbmUtdHVuZSBhcHBsaWNhdGlvbnMgZm9yIHBh
cmFsbGVsIHBlcmZvcm1hbmNlLgpTZWUgd2h5IEludGVsIFBhcmFsbGVsIFN0dWRpbyBnb3QgaGln
aCBtYXJrcyBkdXJpbmcgYmV0YS4KaHR0cDovL3Auc2YubmV0L3NmdS9pbnRlbC1zdy1kZXYKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ2VwaC1kZXZlbCBt
YWlsaW5nIGxpc3QKQ2VwaC1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0
cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vY2VwaC1kZXZlbAo=
