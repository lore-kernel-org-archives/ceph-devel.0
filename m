From: Samuel Just <sjust@redhat.com>
Subject: straw vs straw2 mapping differences
Date: Wed, 6 May 2015 18:20:32 -0400 (EDT)
Message-ID: <810923992.14617375.1430950832629.JavaMail.zimbra@redhat.com>
References: <29256929.14615303.1430950349937.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14617373_693759958.1430950832626"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx3-phx2.redhat.com ([209.132.183.24]:40249 "EHLO
	mx3-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbbEFWUd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 May 2015 18:20:33 -0400
In-Reply-To: <29256929.14615303.1430950349937.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>, "'ceph-users@lists.ceph.com' (ceph-users@lists.ceph.com)" <ceph-users@lists.ceph.com>

------=_Part_14617373_693759958.1430950832626
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I took a bit of time to get a feel for how different the straw2 mappings are vs straw1 mappings.  For a bucket in which all weights are the same, I saw no changed mappings, which is as expected.  However, on a map with 3 hosts each of which has 4 osds with weights 1,2,3, and 4 (crush-different-weight.straw), 1360/10000 mappings wind up different.  Some good news is that this effect is smaller with smaller weight differences.  When the osd weights are 1, 1.1, 1.2, and 1.3 (crush-different-weight-close.straw), only 377/10000 single osd mappings are different.  I've attached a tarball with a script for reproducing the results and the maps I tested.
-Sam
------=_Part_14617373_693759958.1430950832626
Content-Type: application/x-compressed-tar; name=strawtest.tgz
Content-Disposition: attachment; filename=strawtest.tgz
Content-Transfer-Encoding: base64

H4sIAEeTSlUAA+1bbW+rNhTO1/ArPLVSpUkk2Lylmra/EhFwEt8SG2HT3G67++07NiEvJDTtmheu
5ucD8eGxzTm2OTw1VKoyWSsq1XhwNXiAOA71L45Db/+3wQCTkJAQ4yAKBh7GJAgGKLyeSztUUiUl
QgOZrN6td47/SSG385+KVZGUdGrOjOTyctc4M//Yi4Pd/AdQTx/JAHmXc6Eb//P5f/hlPGN8PEvk
0nEeSlrkSUrRmqklehNVicSao7Ss5FIJkSOompRvzvbE7/+MF0y56ZKmL6JScpzSYumPZZmOt3Uc
Zy5KxBDj6NeRWVy/oUw4wzRR6JGhv5GkGXqSY0PVRzJePAGxAHeQ+wqkOTlNkzydvtJSMsGf0B9o
rFbF+JGNiDN83PnoprpbV2xpxtv8tuFhtXZH7opx9zvydCn5DiWslytYvFq52jeMXLbXHhh9J8GP
XIo1tCkKxhdy39NRc/JrV9Ken7vW7koZm8+R+6brVkVRUilduNlXgrs541QetTjh7l6/ujcnE5w6
9167Fl/HXv7Xy9FVa+FCqqPumrLFUtU37BevoddypJ/rp/O/j328yf+eH3sE8n8URL7N/7fAA5rR
BdvkeAS3u6MqnsxyitKlEJJOcwFpd6pKBonCO03OkzyfJelLVy0l1LaLsM3mNJlPMypTyrOp4PDw
wdsaZvEdpH0gnQeU0VeWUunUv5A2hcxGXmNiY+LGJMYkjekb02/MwJhBY4bGDBszMmbUmLEx48ac
GHPSmM/GfN66UbuFd35tHDMhqLcCAtDH2v26iNFSSFWXCQxQIiXb1PJRCUNclwNUinVdDFGRVXUx
QoXY9BNDBbGqyxOUJQoe6lzRsj7zjEqYc8E31/R0ZaWdmlXpC1XS0U4YTzz0lzNkGXLJcAjDLhAX
SrvFFxRVnFOYBJmULH9zgK4zBsJkBDe1M0zyRT2BzhDiWCIPqpTfKH9hXGLoVdFVPW/bhnW7LYEb
grQI0hB+i/APW/zYBYKbQILrBRJ0BRJ2BRJ1BRJ3BkKaQMLrBTLpCuS5KxDsdUWCcTsUR69jZDKH
KW3i8a8TT72KNw0ne87Vq6KDIIfED0ffIZB25kmVq8ZjfB2PdyPTDFzQjBxUrnJIG/qItFZnIKJp
NjVnqXGsKcLFzN29q+UMQWROJftTZ9ghyMxNGWpKBRJTJS+0CXFzapeh0ZyVUnHIVaZXk6XqOnTF
VO0bJPC9x8i9H2wWH0Jb/2l1T0t4WLh6ji8i/z6n/8zf/5Ef27//bwKr/6z+s/rvRvqv7e95/Yfv
qv/aA/8B/XfE9En/xT+n/vOt/rO4Err1X7363DSHJfA1Hfhx/Ye9MI4GHtEvjKz+uwWs/rP6r+/6
D8MgntR/eERO6z888vuo/9qBRF2BxJ2B9GP/rx0I9roiwbgdyh31XzCKTuu/NkEOifvqP+yPJlb/
WVwF5/TfJXYAz+u/YLv/F0VY7//FXmD13y1g9Z/Vf33Xf5/f/wv6uf/3+fe/R4H0Q//9l/e/wf33
/7DXtQF4xJAWc18J6Ht2C9DiGmjrv0t/+6fxmfe/Uay//wujyL7/vQms/rP6r+/6r02QLsI/JHqn
/9pE1EX05P3vO/t/XfrviMHtUO66/9ch/9oEaYvWu+7/ESv+LK6E97//u4wS/NT7X6y//4sjoK3+
uwGs/rP6ryf672hT6ez+X5vo+/d/Vv/19P8/+q3/Iqv/LCwsLCwsLCwsLCwsLL6IfwE1SP8RAFAA
AA==
------=_Part_14617373_693759958.1430950832626--
