From: "Stefan Weil" <Stefan.Weil@weilnetz.de>
Subject: Re: [PATCH] use int64_t for return values from rbd
 instead of int
Date: Wed, 21 Nov 2012 22:26:28 +0100
Message-ID: <b3a439ef40a23230616656041f57d4af.squirrel@weilnetz.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
Sender: qemu-devel-bounces+gceq-qemu-devel=gmane.org@nongnu.org
To: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
List-Id: ceph-devel.vger.kernel.org

                   Am 21.11.2012 21:53, schrieb Stefan       Priebe -
Profihost AG:
                 Not sure about off_t. What is min and max size?  Stefan

     off_t is a signed value which is used in function lseek to
     address any byte of a seekable file.
     The range is typically 64 bit (like int64_t), but may be smaller if
the host only supports 2 GB files.
     Stefan
