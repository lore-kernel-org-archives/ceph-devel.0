From: Evgeniy Firsov <Evgeniy.Firsov@sandisk.com>
Subject: disabling buffer::raw crc cache
Date: Wed, 11 Nov 2015 07:27:19 +0000
Message-ID: <D2682DD5.8AA1%evgeniy.firsov@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bn1on0056.outbound.protection.outlook.com ([157.56.110.56]:36576
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751497AbbKKHmn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Nov 2015 02:42:43 -0500
Content-Language: en-US
Content-ID: <234BD9C5EE3AD14A950B556CCC80010D@namprd02.prod.outlook.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hello, Guys!

While running CPU bound 4k block workload, I found that disabling crc
cache in the buffer::raw gives around 7% performance improvement.

If there is no strong use case which benefit from that cache, we would
remove it entirely, otherwise conditionally enable it based on the obje=
ct
size.

=8B
Evgeniy

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
