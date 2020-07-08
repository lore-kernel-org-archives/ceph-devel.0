From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: CEPH COMMON CODE (LIBCEPH)
Date: Wed, 8 Jul 2020 13:25:35 +0200
Message-ID: <CAOi1vP_vS-nNMXuo4n8njx=pRVUQd-C8LAeSTpVTufqiHsCS-g@mail.gmail.com>
References: <20200708065328.13031-1-grandmaster@al2klimov.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200708065328.13031-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Jeff Layton <jlayton@kernel.org>, "David S. Miller" <davem@davemloft.net>, kuba@kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, netdev <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Wed, Jul 8, 2020 at 8:53 AM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
>
>  If there are any URLs to be removed completely or at least not HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
>
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
>
>  If you apply the patch, please let me know.
>
>
>  net/ceph/ceph_hash.c    | 2 +-
>  net/ceph/crush/hash.c   | 2 +-
>  net/ceph/crush/mapper.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/net/ceph/ceph_hash.c b/net/ceph/ceph_hash.c
> index 9a5850f264ed..81e1e006c540 100644
> --- a/net/ceph/ceph_hash.c
> +++ b/net/ceph/ceph_hash.c
> @@ -4,7 +4,7 @@
>
>  /*
>   * Robert Jenkin's hash function.
> - * http://burtleburtle.net/bob/hash/evahash.html
> + * https://burtleburtle.net/bob/hash/evahash.html
>   * This is in the public domain.
>   */
>  #define mix(a, b, c)                                           \
> diff --git a/net/ceph/crush/hash.c b/net/ceph/crush/hash.c
> index e5cc603cdb17..fe79f6d2d0db 100644
> --- a/net/ceph/crush/hash.c
> +++ b/net/ceph/crush/hash.c
> @@ -7,7 +7,7 @@
>
>  /*
>   * Robert Jenkins' function for mixing 32-bit values
> - * http://burtleburtle.net/bob/hash/evahash.html
> + * https://burtleburtle.net/bob/hash/evahash.html
>   * a, b = random bits, c = input and output
>   */
>  #define crush_hashmix(a, b, c) do {                    \
> diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
> index 3f323ed9df52..07e5614eb3f1 100644
> --- a/net/ceph/crush/mapper.c
> +++ b/net/ceph/crush/mapper.c
> @@ -298,7 +298,7 @@ static __u64 crush_ln(unsigned int xin)
>   *
>   * for reference, see:
>   *
> - * http://en.wikipedia.org/wiki/Exponential_distribution#Distribution_of_the_minimum_of_exponential_random_variables
> + * https://en.wikipedia.org/wiki/Exponential_distribution#Distribution_of_the_minimum_of_exponential_random_variables
>   *
>   */
>

Applied with a couple more link fixes folded in.

Thanks,

                Ilya
