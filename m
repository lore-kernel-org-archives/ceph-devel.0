From: Matt Conner <matt.conner@keepertech.com>
Subject: Re: Failed OSDs not getting marked down or out
Date: Thu, 19 Mar 2015 11:47:24 -0400
Message-ID: <CAKeiORQGdqDGzXCWfCKWLX6Xf9sn3K8JKUhFiWror8hvhnBAKQ@mail.gmail.com>
References: <CAKeiORT21fyG0WcdgJC6Gbnpe90y_SM+VuOJDML8NXR9dG2sZA@mail.gmail.com>
	<alpine.DEB.2.00.1503181256160.3716@cobra.newdream.net>
	<CAC6JEv9SMnuXE80Y8jtMv_Qsf7MpcCAmsYjV3r5ju1B7838+kg@mail.gmail.com>
	<CAKeiORShxjnSVO9cRJC9ucrq-UWgRXLgqkt_Q8WO+2T7rHn2dg@mail.gmail.com>
	<CAC6JEv8TJaybJhYpq067Bhrz86f9CHtY8Lz9haKXtqED34e+Hw@mail.gmail.com>
	<alpine.DEB.2.00.1503190758590.7043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33111 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbCSPrZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 19 Mar 2015 11:47:25 -0400
Received: by obcxo2 with SMTP id xo2so57603188obc.0
        for <ceph-devel@vger.kernel.org>; Thu, 19 Mar 2015 08:47:25 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1503190758590.7043@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Gregory Farnum <greg@gregs42.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've the crush map below.

Sage,

We are setting the cluster for 10 pools at 10% each, but we only have
1 pool currently in the system. Because of this the average is only 20
PGs per OSD, with it ranging anywhere between 0 and 41 PGs on an OSD.
Any ideas as to why the hash would be distributing PGs that unevenly?
It is not that uncommon for us to see a distribution such as that - we
attempted to fill a smaller cluster and the distribution was so wide
that we had one OSD hit 95% full while the next closest was around 80%
(had more PGs and more objects per PG). All OSDs ere weighted the
same.

Thanks,
Matt

(Long crush map below)
-----------------------------------------------------------------------------------------------------------------
# begin crush map
tunable choose_local_tries 0
tunable choose_local_fallback_tries 0
tunable choose_total_tries 50
tunable chooseleaf_descend_once 1
tunable chooseleaf_vary_r 1
tunable straw_calc_version 1

# devices
device 0 osd.0
device 1 osd.1
device 2 osd.2
device 3 osd.3
device 4 osd.4
device 5 osd.5
device 6 osd.6
device 7 osd.7
device 8 osd.8
device 9 osd.9
device 10 osd.10
device 11 osd.11
device 12 osd.12
device 13 osd.13
device 14 osd.14
device 15 osd.15
device 16 osd.16
device 17 osd.17
device 18 osd.18
device 19 osd.19
device 20 osd.20
device 21 osd.21
device 22 osd.22
device 23 osd.23
device 24 osd.24
device 25 osd.25
device 26 osd.26
device 27 osd.27
device 28 osd.28
device 29 osd.29
device 30 osd.30
device 31 osd.31
device 32 osd.32
device 33 osd.33
device 34 osd.34
device 35 osd.35
device 36 osd.36
device 37 osd.37
device 38 osd.38
device 39 osd.39
device 40 osd.40
device 41 osd.41
device 42 osd.42
device 43 osd.43
device 44 osd.44
device 45 osd.45
device 46 osd.46
device 47 osd.47
device 48 osd.48
device 49 osd.49
device 50 osd.50
device 51 osd.51
device 52 osd.52
device 53 osd.53
device 54 osd.54
device 55 osd.55
device 56 osd.56
device 57 osd.57
device 58 osd.58
device 59 osd.59
device 60 osd.60
device 61 osd.61
device 62 osd.62
device 63 osd.63
device 64 osd.64
device 65 osd.65
device 66 osd.66
device 67 osd.67
device 68 osd.68
device 69 osd.69
device 70 osd.70
device 71 osd.71
device 72 osd.72
device 73 osd.73
device 74 osd.74
device 75 osd.75
device 76 osd.76
device 77 osd.77
device 78 osd.78
device 79 osd.79
device 80 osd.80
device 81 osd.81
device 82 osd.82
device 83 osd.83
device 84 osd.84
device 85 osd.85
device 86 osd.86
device 87 osd.87
device 88 osd.88
device 89 osd.89
device 90 osd.90
device 91 osd.91
device 92 osd.92
device 93 osd.93
device 94 osd.94
device 95 osd.95
device 96 osd.96
device 97 osd.97
device 98 osd.98
device 99 osd.99
device 100 osd.100
device 101 osd.101
device 102 osd.102
device 103 osd.103
device 104 osd.104
device 105 osd.105
device 106 osd.106
device 107 osd.107
device 108 osd.108
device 109 osd.109
device 110 osd.110
device 111 osd.111
device 112 osd.112
device 113 osd.113
device 114 osd.114
device 115 osd.115
device 116 osd.116
device 117 osd.117
device 118 osd.118
device 119 osd.119
device 120 osd.120
device 121 osd.121
device 122 osd.122
device 123 osd.123
device 124 osd.124
device 125 osd.125
device 126 osd.126
device 127 osd.127
device 128 osd.128
device 129 osd.129
device 130 osd.130
device 131 osd.131
device 132 osd.132
device 133 osd.133
device 134 osd.134
device 135 osd.135
device 136 osd.136
device 137 osd.137
device 138 osd.138
device 139 osd.139
device 140 osd.140
device 141 osd.141
device 142 osd.142
device 143 osd.143
device 144 osd.144
device 145 osd.145
device 146 osd.146
device 147 osd.147
device 148 osd.148
device 149 osd.149
device 150 osd.150
device 151 osd.151
device 152 osd.152
device 153 osd.153
device 154 osd.154
device 155 osd.155
device 156 osd.156
device 157 osd.157
device 158 osd.158
device 159 osd.159
device 160 osd.160
device 161 osd.161
device 162 osd.162
device 163 osd.163
device 164 osd.164
device 165 osd.165
device 166 osd.166
device 167 osd.167
device 168 osd.168
device 169 osd.169
device 170 osd.170
device 171 osd.171
device 172 osd.172
device 173 osd.173
device 174 osd.174
device 175 osd.175
device 176 osd.176
device 177 osd.177
device 178 osd.178
device 179 osd.179
device 180 osd.180
device 181 osd.181
device 182 osd.182
device 183 osd.183
device 184 osd.184
device 185 osd.185
device 186 osd.186
device 187 osd.187
device 188 osd.188
device 189 osd.189
device 190 osd.190
device 191 osd.191
device 192 osd.192
device 193 osd.193
device 194 osd.194
device 195 osd.195
device 196 osd.196
device 197 osd.197
device 198 osd.198
device 199 osd.199
device 200 osd.200
device 201 osd.201
device 202 osd.202
device 203 osd.203
device 204 osd.204
device 205 osd.205
device 206 osd.206
device 207 osd.207
device 208 osd.208
device 209 osd.209
device 210 osd.210
device 211 osd.211
device 212 osd.212
device 213 osd.213
device 214 osd.214
device 215 osd.215
device 216 osd.216
device 217 osd.217
device 218 osd.218
device 219 osd.219
device 220 osd.220
device 221 osd.221
device 222 osd.222
device 223 osd.223
device 224 osd.224
device 225 osd.225
device 226 osd.226
device 227 osd.227
device 228 osd.228
device 229 osd.229
device 230 osd.230
device 231 osd.231
device 232 osd.232
device 233 osd.233
device 234 osd.234
device 235 osd.235
device 236 osd.236
device 237 osd.237
device 238 osd.238
device 239 osd.239
device 240 osd.240
device 241 osd.241
device 242 osd.242
device 243 osd.243
device 244 osd.244
device 245 osd.245
device 246 osd.246
device 247 osd.247
device 248 osd.248
device 249 osd.249
device 250 osd.250
device 251 osd.251
device 252 osd.252
device 253 osd.253
device 254 osd.254
device 255 osd.255
device 256 osd.256
device 257 osd.257
device 258 osd.258
device 259 osd.259
device 260 osd.260
device 261 osd.261
device 262 osd.262
device 263 osd.263
device 264 osd.264
device 265 osd.265
device 266 osd.266
device 267 osd.267
device 268 osd.268
device 269 osd.269
device 270 osd.270
device 271 osd.271
device 272 osd.272
device 273 osd.273
device 274 osd.274
device 275 osd.275
device 276 osd.276
device 277 osd.277
device 278 osd.278
device 279 osd.279
device 280 osd.280
device 281 osd.281
device 282 osd.282
device 283 osd.283
device 284 osd.284
device 285 osd.285
device 286 osd.286
device 287 osd.287
device 288 osd.288
device 289 osd.289
device 290 osd.290
device 291 osd.291
device 292 osd.292
device 293 osd.293
device 294 osd.294
device 295 osd.295
device 296 osd.296
device 297 osd.297
device 298 osd.298
device 299 osd.299
device 300 osd.300
device 301 osd.301
device 302 osd.302
device 303 osd.303
device 304 osd.304
device 305 osd.305
device 306 osd.306
device 307 osd.307
device 308 osd.308
device 309 osd.309
device 310 osd.310
device 311 osd.311
device 312 osd.312
device 313 osd.313
device 314 osd.314
device 315 osd.315
device 316 osd.316
device 317 osd.317
device 318 osd.318
device 319 osd.319
device 320 osd.320
device 321 osd.321
device 322 osd.322
device 323 osd.323
device 324 osd.324
device 325 osd.325
device 326 osd.326
device 327 osd.327
device 328 osd.328
device 329 osd.329
device 330 osd.330
device 331 osd.331
device 332 osd.332
device 333 osd.333
device 334 osd.334
device 335 osd.335
device 336 osd.336
device 337 osd.337
device 338 osd.338
device 339 osd.339
device 340 osd.340
device 341 osd.341
device 342 osd.342
device 343 osd.343
device 344 osd.344
device 345 osd.345
device 346 osd.346
device 347 osd.347
device 348 osd.348
device 349 osd.349
device 350 osd.350
device 351 osd.351
device 352 osd.352
device 353 osd.353
device 354 osd.354
device 355 osd.355
device 356 osd.356
device 357 osd.357
device 358 osd.358
device 359 osd.359
device 360 osd.360
device 361 osd.361
device 362 osd.362
device 363 osd.363
device 364 osd.364
device 365 osd.365
device 366 osd.366
device 367 osd.367
device 368 osd.368
device 369 osd.369
device 370 osd.370
device 371 osd.371
device 372 osd.372
device 373 osd.373
device 374 osd.374
device 375 osd.375
device 376 osd.376
device 377 osd.377
device 378 osd.378
device 379 osd.379
device 380 osd.380
device 381 osd.381
device 382 osd.382
device 383 osd.383
device 384 osd.384
device 385 osd.385
device 386 osd.386
device 387 osd.387
device 388 osd.388
device 389 osd.389
device 390 osd.390
device 391 osd.391
device 392 osd.392
device 393 osd.393
device 394 osd.394
device 395 osd.395
device 396 osd.396
device 397 osd.397
device 398 osd.398
device 399 osd.399
device 400 osd.400
device 401 osd.401
device 402 osd.402
device 403 osd.403
device 404 osd.404
device 405 osd.405
device 406 osd.406
device 407 osd.407
device 408 osd.408
device 409 osd.409
device 410 osd.410
device 411 osd.411
device 412 osd.412
device 413 osd.413
device 414 osd.414
device 415 osd.415
device 416 osd.416
device 417 osd.417
device 418 osd.418
device 419 osd.419
device 420 osd.420
device 421 osd.421
device 422 osd.422
device 423 osd.423
device 424 osd.424
device 425 osd.425
device 426 osd.426
device 427 osd.427
device 428 osd.428
device 429 osd.429
device 430 osd.430
device 431 osd.431
device 432 osd.432
device 433 osd.433
device 434 osd.434
device 435 osd.435
device 436 osd.436
device 437 osd.437
device 438 osd.438
device 439 osd.439
device 440 osd.440
device 441 osd.441
device 442 osd.442
device 443 osd.443
device 444 osd.444
device 445 osd.445
device 446 osd.446
device 447 osd.447
device 448 osd.448
device 449 osd.449
device 450 osd.450
device 451 osd.451
device 452 osd.452
device 453 osd.453
device 454 osd.454
device 455 osd.455
device 456 osd.456
device 457 osd.457
device 458 osd.458
device 459 osd.459
device 460 osd.460
device 461 osd.461
device 462 osd.462
device 463 osd.463
device 464 osd.464
device 465 osd.465
device 466 osd.466
device 467 osd.467
device 468 osd.468
device 469 osd.469
device 470 osd.470
device 471 osd.471
device 472 osd.472
device 473 osd.473
device 474 osd.474
device 475 osd.475
device 476 osd.476
device 477 osd.477
device 478 osd.478
device 479 osd.479
device 480 osd.480
device 481 osd.481
device 482 osd.482
device 483 osd.483
device 484 osd.484
device 485 osd.485
device 486 osd.486
device 487 osd.487
device 488 osd.488
device 489 osd.489
device 490 osd.490
device 491 osd.491
device 492 osd.492
device 493 osd.493
device 494 osd.494
device 495 osd.495
device 496 osd.496
device 497 osd.497
device 498 osd.498
device 499 osd.499
device 500 osd.500
device 501 osd.501
device 502 osd.502
device 503 osd.503
device 504 osd.504
device 505 osd.505
device 506 osd.506
device 507 osd.507
device 508 osd.508
device 509 osd.509
device 510 osd.510
device 511 osd.511
device 512 osd.512
device 513 osd.513
device 514 osd.514
device 515 osd.515
device 516 osd.516
device 517 osd.517
device 518 osd.518
device 519 osd.519
device 520 osd.520
device 521 osd.521
device 522 osd.522
device 523 osd.523
device 524 osd.524
device 525 osd.525
device 526 osd.526
device 527 osd.527
device 528 osd.528
device 529 osd.529
device 530 osd.530
device 531 osd.531
device 532 osd.532
device 533 osd.533
device 534 osd.534
device 535 osd.535
device 536 osd.536
device 537 osd.537
device 538 osd.538
device 539 osd.539
device 540 osd.540
device 541 osd.541
device 542 osd.542
device 543 osd.543
device 544 osd.544
device 545 osd.545
device 546 osd.546
device 547 osd.547
device 548 osd.548
device 549 osd.549
device 550 osd.550
device 551 osd.551
device 552 osd.552
device 553 osd.553
device 554 osd.554
device 555 osd.555
device 556 osd.556
device 557 osd.557
device 558 osd.558
device 559 osd.559
device 560 osd.560
device 561 osd.561
device 562 osd.562
device 563 osd.563
device 564 osd.564
device 565 osd.565
device 566 osd.566
device 567 osd.567
device 568 osd.568
device 569 osd.569
device 570 osd.570
device 571 osd.571
device 572 osd.572
device 573 osd.573
device 574 osd.574
device 575 osd.575
device 576 osd.576
device 577 osd.577
device 578 osd.578
device 579 osd.579
device 580 osd.580
device 581 osd.581
device 582 osd.582
device 583 osd.583
device 584 osd.584
device 585 osd.585
device 586 osd.586
device 587 osd.587
device 588 osd.588
device 589 osd.589
device 590 osd.590
device 591 osd.591
device 592 osd.592
device 593 osd.593
device 594 osd.594
device 595 osd.595
device 596 osd.596
device 597 osd.597
device 598 osd.598
device 599 osd.599
device 600 osd.600
device 601 osd.601
device 602 osd.602
device 603 osd.603
device 604 osd.604
device 605 osd.605
device 606 osd.606
device 607 osd.607
device 608 osd.608
device 609 osd.609
device 610 osd.610
device 611 osd.611
device 612 osd.612
device 613 osd.613
device 614 osd.614
device 615 osd.615
device 616 osd.616
device 617 osd.617
device 618 osd.618
device 619 osd.619
device 620 osd.620
device 621 osd.621
device 622 osd.622
device 623 osd.623
device 624 osd.624
device 625 osd.625
device 626 osd.626
device 627 osd.627
device 628 osd.628
device 629 osd.629
device 630 osd.630
device 631 osd.631
device 632 osd.632
device 633 osd.633
device 634 osd.634
device 635 osd.635
device 636 osd.636
device 637 osd.637
device 638 osd.638
device 639 osd.639
device 640 osd.640
device 641 osd.641
device 642 osd.642
device 643 osd.643
device 644 osd.644
device 645 osd.645
device 646 osd.646
device 647 osd.647

# types
type 0 osd
type 1 host
type 2 chassis
type 3 rack
type 4 row
type 5 pdu
type 6 pod
type 7 room
type 8 datacenter
type 9 region
type 10 root

# buckets
host ss001 {
id -12 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.2 weight 5.450
item osd.19 weight 5.450
item osd.41 weight 5.450
item osd.58 weight 5.450
item osd.76 weight 5.450
item osd.89 weight 5.450
item osd.108 weight 5.450
item osd.122 weight 5.450
item osd.140 weight 5.450
item osd.158 weight 5.450
item osd.177 weight 5.450
item osd.193 weight 5.450
item osd.211 weight 5.450
item osd.229 weight 5.450
item osd.245 weight 5.450
item osd.260 weight 5.450
item osd.280 weight 5.450
item osd.295 weight 5.450
item osd.316 weight 5.450
item osd.331 weight 5.450
item osd.347 weight 5.450
item osd.366 weight 5.450
item osd.384 weight 5.450
item osd.400 weight 5.450
item osd.417 weight 5.450
item osd.435 weight 5.450
item osd.450 weight 5.450
item osd.471 weight 5.450
item osd.486 weight 5.450
item osd.503 weight 5.450
item osd.520 weight 5.450
item osd.535 weight 5.450
item osd.553 weight 5.450
item osd.571 weight 5.450
item osd.588 weight 5.450
item osd.606 weight 5.450
}
host ss002 {
id -16 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.13 weight 5.450
item osd.32 weight 5.450
item osd.49 weight 5.450
item osd.64 weight 5.450
item osd.80 weight 5.450
item osd.97 weight 5.450
item osd.114 weight 5.450
item osd.130 weight 5.450
item osd.146 weight 5.450
item osd.161 weight 5.450
item osd.181 weight 5.450
item osd.195 weight 5.450
item osd.212 weight 5.450
item osd.230 weight 5.450
item osd.246 weight 5.450
item osd.264 weight 5.450
item osd.282 weight 5.450
item osd.299 weight 5.450
item osd.315 weight 5.450
item osd.335 weight 5.450
item osd.351 weight 5.450
item osd.368 weight 5.450
item osd.387 weight 5.450
item osd.403 weight 5.450
item osd.420 weight 5.450
item osd.439 weight 5.450
item osd.454 weight 5.450
item osd.474 weight 5.450
item osd.489 weight 5.450
item osd.507 weight 5.450
item osd.525 weight 5.450
item osd.542 weight 5.450
item osd.559 weight 5.450
item osd.576 weight 5.450
item osd.593 weight 5.450
item osd.610 weight 5.450
}
host ss013 {
id -13 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.10 weight 5.450
item osd.22 weight 5.450
item osd.43 weight 5.450
item osd.52 weight 5.450
item osd.70 weight 5.450
item osd.92 weight 5.450
item osd.109 weight 5.450
item osd.125 weight 5.450
item osd.144 weight 5.450
item osd.163 weight 5.450
item osd.180 weight 5.450
item osd.197 weight 5.450
item osd.214 weight 5.450
item osd.227 weight 5.450
item osd.243 weight 5.450
item osd.261 weight 5.450
item osd.281 weight 5.450
item osd.296 weight 5.450
item osd.310 weight 5.450
item osd.329 weight 5.450
item osd.345 weight 5.450
item osd.362 weight 5.450
item osd.376 weight 5.450
item osd.396 weight 5.450
item osd.411 weight 5.450
item osd.428 weight 5.450
item osd.446 weight 5.450
item osd.463 weight 5.450
item osd.480 weight 5.450
item osd.498 weight 5.450
item osd.513 weight 5.450
item osd.531 weight 5.450
item osd.548 weight 5.450
item osd.562 weight 5.450
item osd.582 weight 5.450
item osd.599 weight 5.450
}
host ss014 {
id -6 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.11 weight 5.450
item osd.23 weight 5.450
item osd.39 weight 5.450
item osd.53 weight 5.450
item osd.69 weight 5.450
item osd.86 weight 5.450
item osd.103 weight 5.450
item osd.120 weight 5.450
item osd.137 weight 5.450
item osd.154 weight 5.450
item osd.171 weight 5.450
item osd.188 weight 5.450
item osd.205 weight 5.450
item osd.222 weight 5.450
item osd.239 weight 5.450
item osd.257 weight 5.450
item osd.273 weight 5.450
item osd.290 weight 5.450
item osd.307 weight 5.450
item osd.326 weight 5.450
item osd.341 weight 5.450
item osd.358 weight 5.450
item osd.375 weight 5.450
item osd.392 weight 5.450
item osd.410 weight 5.450
item osd.427 weight 5.450
item osd.443 weight 5.450
item osd.461 weight 5.450
item osd.479 weight 5.450
item osd.494 weight 5.450
item osd.510 weight 5.450
item osd.529 weight 5.450
item osd.544 weight 5.450
item osd.564 weight 5.450
item osd.579 weight 5.450
item osd.595 weight 5.450
}
rack 1 {
id -19 # do not change unnecessarily
# weight 784.800
alg straw
hash 0 # rjenkins1
item ss001 weight 196.200
item ss002 weight 196.200
item ss013 weight 196.200
item ss014 weight 196.200
}
host ss003 {
id -14 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.1 weight 5.450
item osd.28 weight 5.450
item osd.37 weight 5.450
item osd.55 weight 5.450
item osd.74 weight 5.450
item osd.87 weight 5.450
item osd.107 weight 5.450
item osd.121 weight 5.450
item osd.138 weight 5.450
item osd.157 weight 5.450
item osd.175 weight 5.450
item osd.192 weight 5.450
item osd.207 weight 5.450
item osd.224 weight 5.450
item osd.242 weight 5.450
item osd.259 weight 5.450
item osd.277 weight 5.450
item osd.291 weight 5.450
item osd.309 weight 5.450
item osd.325 weight 5.450
item osd.343 weight 5.450
item osd.360 weight 5.450
item osd.377 weight 5.450
item osd.395 weight 5.450
item osd.412 weight 5.450
item osd.429 weight 5.450
item osd.448 weight 5.450
item osd.465 weight 5.450
item osd.483 weight 5.450
item osd.500 weight 5.450
item osd.514 weight 5.450
item osd.532 weight 5.450
item osd.549 weight 5.450
item osd.566 weight 5.450
item osd.581 weight 5.450
item osd.600 weight 5.450
}
host ss004 {
id -7 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.6 weight 5.450
item osd.25 weight 5.450
item osd.40 weight 5.450
item osd.60 weight 5.450
item osd.75 weight 5.450
item osd.88 weight 5.450
item osd.106 weight 5.450
item osd.126 weight 5.450
item osd.142 weight 5.450
item osd.159 weight 5.450
item osd.173 weight 5.450
item osd.190 weight 5.450
item osd.208 weight 5.450
item osd.225 weight 5.450
item osd.244 weight 5.450
item osd.265 weight 5.450
item osd.279 weight 5.450
item osd.298 weight 5.450
item osd.314 weight 5.450
item osd.332 weight 5.450
item osd.350 weight 5.450
item osd.363 weight 5.450
item osd.382 weight 5.450
item osd.398 weight 5.450
item osd.416 weight 5.450
item osd.433 weight 5.450
item osd.451 weight 5.450
item osd.468 weight 5.450
item osd.484 weight 5.450
item osd.502 weight 5.450
item osd.519 weight 5.450
item osd.536 weight 5.450
item osd.554 weight 5.450
item osd.569 weight 5.450
item osd.591 weight 5.450
item osd.609 weight 5.450
}
host ss015 {
id -3 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.5 weight 5.450
item osd.26 weight 5.450
item osd.45 weight 5.450
item osd.59 weight 5.450
item osd.73 weight 5.450
item osd.91 weight 5.450
item osd.104 weight 5.450
item osd.124 weight 5.450
item osd.141 weight 5.450
item osd.156 weight 5.450
item osd.174 weight 5.450
item osd.191 weight 5.450
item osd.210 weight 5.450
item osd.228 weight 5.450
item osd.248 weight 5.450
item osd.262 weight 5.450
item osd.278 weight 5.450
item osd.297 weight 5.450
item osd.311 weight 5.450
item osd.328 weight 5.450
item osd.349 weight 5.450
item osd.367 weight 5.450
item osd.381 weight 5.450
item osd.397 weight 5.450
item osd.414 weight 5.450
item osd.431 weight 5.450
item osd.447 weight 5.450
item osd.466 weight 5.450
item osd.482 weight 5.450
item osd.499 weight 5.450
item osd.516 weight 5.450
item osd.534 weight 5.450
item osd.550 weight 5.450
item osd.567 weight 5.450
item osd.584 weight 5.450
item osd.602 weight 5.450
}
host ss016 {
id -8 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.3 weight 5.450
item osd.20 weight 5.450
item osd.36 weight 5.450
item osd.61 weight 5.450
item osd.81 weight 5.450
item osd.98 weight 5.450
item osd.115 weight 5.450
item osd.131 weight 5.450
item osd.149 weight 5.450
item osd.165 weight 5.450
item osd.183 weight 5.450
item osd.201 weight 5.450
item osd.216 weight 5.450
item osd.234 weight 5.450
item osd.253 weight 5.450
item osd.269 weight 5.450
item osd.287 weight 5.450
item osd.305 weight 5.450
item osd.319 weight 5.450
item osd.336 weight 5.450
item osd.354 weight 5.450
item osd.372 weight 5.450
item osd.386 weight 5.450
item osd.406 weight 5.450
item osd.423 weight 5.450
item osd.437 weight 5.450
item osd.455 weight 5.450
item osd.472 weight 5.450
item osd.488 weight 5.450
item osd.505 weight 5.450
item osd.522 weight 5.450
item osd.541 weight 5.450
item osd.555 weight 5.450
item osd.572 weight 5.450
item osd.589 weight 5.450
item osd.607 weight 5.450
}
rack 2 {
id -20 # do not change unnecessarily
# weight 784.800
alg straw
hash 0 # rjenkins1
item ss003 weight 196.200
item ss004 weight 196.200
item ss015 weight 196.200
item ss016 weight 196.200
}
host ss005 {
id -17 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.15 weight 5.450
item osd.31 weight 5.450
item osd.50 weight 5.450
item osd.66 weight 5.450
item osd.83 weight 5.450
item osd.100 weight 5.450
item osd.118 weight 5.450
item osd.134 weight 5.450
item osd.151 weight 5.450
item osd.168 weight 5.450
item osd.185 weight 5.450
item osd.203 weight 5.450
item osd.218 weight 5.450
item osd.233 weight 5.450
item osd.250 weight 5.450
item osd.268 weight 5.450
item osd.285 weight 5.450
item osd.302 weight 5.450
item osd.322 weight 5.450
item osd.339 weight 5.450
item osd.356 weight 5.450
item osd.373 weight 5.450
item osd.390 weight 5.450
item osd.407 weight 5.450
item osd.424 weight 5.450
item osd.441 weight 5.450
item osd.458 weight 5.450
item osd.475 weight 5.450
item osd.491 weight 5.450
item osd.509 weight 5.450
item osd.526 weight 5.450
item osd.543 weight 5.450
item osd.560 weight 5.450
item osd.577 weight 5.450
item osd.594 weight 5.450
item osd.611 weight 5.450
}
host ss006 {
id -4 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.8 weight 5.450
item osd.18 weight 5.450
item osd.46 weight 5.450
item osd.62 weight 5.450
item osd.79 weight 5.450
item osd.94 weight 5.450
item osd.113 weight 5.450
item osd.128 weight 5.450
item osd.143 weight 5.450
item osd.162 weight 5.450
item osd.179 weight 5.450
item osd.196 weight 5.450
item osd.213 weight 5.450
item osd.232 weight 5.450
item osd.247 weight 5.450
item osd.266 weight 5.450
item osd.283 weight 5.450
item osd.301 weight 5.450
item osd.317 weight 5.450
item osd.333 weight 5.450
item osd.348 weight 5.450
item osd.364 weight 5.450
item osd.383 weight 5.450
item osd.401 weight 5.450
item osd.418 weight 5.450
item osd.434 weight 5.450
item osd.449 weight 5.450
item osd.464 weight 5.450
item osd.481 weight 5.450
item osd.497 weight 5.450
item osd.515 weight 5.450
item osd.533 weight 5.450
item osd.552 weight 5.450
item osd.570 weight 5.450
item osd.587 weight 5.450
item osd.601 weight 5.450
}
host ss017 {
id -2 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.0 weight 5.450
item osd.17 weight 5.450
item osd.34 weight 5.450
item osd.51 weight 5.450
item osd.68 weight 5.450
item osd.85 weight 5.450
item osd.102 weight 5.450
item osd.119 weight 5.450
item osd.136 weight 5.450
item osd.153 weight 5.450
item osd.170 weight 5.450
item osd.187 weight 5.450
item osd.204 weight 5.450
item osd.221 weight 5.450
item osd.238 weight 5.450
item osd.255 weight 5.450
item osd.272 weight 5.450
item osd.289 weight 5.450
item osd.306 weight 5.450
item osd.323 weight 5.450
item osd.340 weight 5.450
item osd.357 weight 5.450
item osd.374 weight 5.450
item osd.391 weight 5.450
item osd.408 weight 5.450
item osd.425 weight 5.450
item osd.442 weight 5.450
item osd.460 weight 5.450
item osd.476 weight 5.450
item osd.495 weight 5.450
item osd.511 weight 5.450
item osd.527 weight 5.450
item osd.546 weight 5.450
item osd.561 weight 5.450
item osd.578 weight 5.450
item osd.596 weight 5.450
}
host ss018 {
id -18 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.14 weight 5.450
item osd.33 weight 5.450
item osd.48 weight 5.450
item osd.65 weight 5.450
item osd.82 weight 5.450
item osd.99 weight 5.450
item osd.116 weight 5.450
item osd.133 weight 5.450
item osd.148 weight 5.450
item osd.166 weight 5.450
item osd.184 weight 5.450
item osd.200 weight 5.450
item osd.219 weight 5.450
item osd.235 weight 5.450
item osd.252 weight 5.450
item osd.270 weight 5.450
item osd.288 weight 5.450
item osd.304 weight 5.450
item osd.321 weight 5.450
item osd.338 weight 5.450
item osd.355 weight 5.450
item osd.371 weight 5.450
item osd.385 weight 5.450
item osd.405 weight 5.450
item osd.419 weight 5.450
item osd.436 weight 5.450
item osd.452 weight 5.450
item osd.470 weight 5.450
item osd.487 weight 5.450
item osd.501 weight 5.450
item osd.521 weight 5.450
item osd.538 weight 5.450
item osd.556 weight 5.450
item osd.573 weight 5.450
item osd.586 weight 5.450
item osd.604 weight 5.450
}
rack 3 {
id -21 # do not change unnecessarily
# weight 784.800
alg straw
hash 0 # rjenkins1
item ss005 weight 196.200
item ss006 weight 196.200
item ss017 weight 196.200
item ss018 weight 196.200
}
host ss007 {
id -5 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.4 weight 5.450
item osd.29 weight 5.450
item osd.44 weight 5.450
item osd.67 weight 5.450
item osd.84 weight 5.450
item osd.101 weight 5.450
item osd.117 weight 5.450
item osd.132 weight 5.450
item osd.150 weight 5.450
item osd.167 weight 5.450
item osd.182 weight 5.450
item osd.199 weight 5.450
item osd.217 weight 5.450
item osd.236 weight 5.450
item osd.251 weight 5.450
item osd.267 weight 5.450
item osd.284 weight 5.450
item osd.300 weight 5.450
item osd.318 weight 5.450
item osd.334 weight 5.450
item osd.353 weight 5.450
item osd.370 weight 5.450
item osd.389 weight 5.450
item osd.402 weight 5.450
item osd.421 weight 5.450
item osd.440 weight 5.450
item osd.456 weight 5.450
item osd.469 weight 5.450
item osd.492 weight 5.450
item osd.506 weight 5.450
item osd.524 weight 5.450
item osd.539 weight 5.450
item osd.558 weight 5.450
item osd.575 weight 5.450
item osd.592 weight 5.450
item osd.608 weight 5.450
}
host ss008 {
id -25 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.612 weight 5.450
item osd.613 weight 5.450
item osd.614 weight 5.450
item osd.615 weight 5.450
item osd.616 weight 5.450
item osd.617 weight 5.450
item osd.618 weight 5.450
item osd.619 weight 5.450
item osd.620 weight 5.450
item osd.621 weight 5.450
item osd.622 weight 5.450
item osd.623 weight 5.450
item osd.624 weight 5.450
item osd.625 weight 5.450
item osd.626 weight 5.450
item osd.627 weight 5.450
item osd.628 weight 5.450
item osd.629 weight 5.450
item osd.630 weight 5.450
item osd.631 weight 5.450
item osd.632 weight 5.450
item osd.633 weight 5.450
item osd.634 weight 5.450
item osd.635 weight 5.450
item osd.636 weight 5.450
item osd.637 weight 5.450
item osd.638 weight 5.450
item osd.639 weight 5.450
item osd.640 weight 5.450
item osd.641 weight 5.450
item osd.642 weight 5.450
item osd.643 weight 5.450
item osd.644 weight 5.450
item osd.645 weight 5.450
item osd.646 weight 5.450
item osd.647 weight 5.450
}
rack 4 {
id -22 # do not change unnecessarily
# weight 392.400
alg straw
hash 0 # rjenkins1
item ss007 weight 196.200
item ss008 weight 196.200
}
host ss009 {
id -15 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.16 weight 5.450
item osd.30 weight 5.450
item osd.47 weight 5.450
item osd.63 weight 5.450
item osd.78 weight 5.450
item osd.95 weight 5.450
item osd.111 weight 5.450
item osd.135 weight 5.450
item osd.152 weight 5.450
item osd.169 weight 5.450
item osd.186 weight 5.450
item osd.202 weight 5.450
item osd.220 weight 5.450
item osd.237 weight 5.450
item osd.254 weight 5.450
item osd.271 weight 5.450
item osd.286 weight 5.450
item osd.303 weight 5.450
item osd.320 weight 5.450
item osd.337 weight 5.450
item osd.352 weight 5.450
item osd.369 weight 5.450
item osd.388 weight 5.450
item osd.404 weight 5.450
item osd.422 weight 5.450
item osd.438 weight 5.450
item osd.457 weight 5.450
item osd.473 weight 5.450
item osd.490 weight 5.450
item osd.508 weight 5.450
item osd.523 weight 5.450
item osd.540 weight 5.450
item osd.557 weight 5.450
item osd.574 weight 5.450
item osd.590 weight 5.450
item osd.605 weight 5.450
}
host ss010 {
id -11 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.9 weight 5.450
item osd.21 weight 5.450
item osd.38 weight 5.450
item osd.54 weight 5.450
item osd.71 weight 5.450
item osd.93 weight 5.450
item osd.110 weight 5.450
item osd.127 weight 5.450
item osd.145 weight 5.450
item osd.160 weight 5.450
item osd.178 weight 5.450
item osd.198 weight 5.450
item osd.215 weight 5.450
item osd.231 weight 5.450
item osd.249 weight 5.450
item osd.263 weight 5.450
item osd.276 weight 5.450
item osd.293 weight 5.450
item osd.313 weight 5.450
item osd.330 weight 5.450
item osd.346 weight 5.450
item osd.365 weight 5.450
item osd.380 weight 5.450
item osd.399 weight 5.450
item osd.415 weight 5.450
item osd.432 weight 5.450
item osd.453 weight 5.450
item osd.467 weight 5.450
item osd.485 weight 5.450
item osd.504 weight 5.450
item osd.518 weight 5.450
item osd.537 weight 5.450
item osd.551 weight 5.450
item osd.568 weight 5.450
item osd.585 weight 5.450
item osd.603 weight 5.450
}
rack 5 {
id -23 # do not change unnecessarily
# weight 392.400
alg straw
hash 0 # rjenkins1
item ss009 weight 196.200
item ss010 weight 196.200
}
host ss011 {
id -10 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.12 weight 5.450
item osd.27 weight 5.450
item osd.42 weight 5.450
item osd.57 weight 5.450
item osd.72 weight 5.450
item osd.90 weight 5.450
item osd.105 weight 5.450
item osd.123 weight 5.450
item osd.139 weight 5.450
item osd.155 weight 5.450
item osd.172 weight 5.450
item osd.189 weight 5.450
item osd.206 weight 5.450
item osd.223 weight 5.450
item osd.240 weight 5.450
item osd.256 weight 5.450
item osd.274 weight 5.450
item osd.292 weight 5.450
item osd.312 weight 5.450
item osd.327 weight 5.450
item osd.344 weight 5.450
item osd.361 weight 5.450
item osd.379 weight 5.450
item osd.393 weight 5.450
item osd.413 weight 5.450
item osd.430 weight 5.450
item osd.444 weight 5.450
item osd.462 weight 5.450
item osd.478 weight 5.450
item osd.496 weight 5.450
item osd.517 weight 5.450
item osd.530 weight 5.450
item osd.545 weight 5.450
item osd.565 weight 5.450
item osd.580 weight 5.450
item osd.597 weight 5.450
}
host ss012 {
id -9 # do not change unnecessarily
# weight 196.200
alg straw
hash 0 # rjenkins1
item osd.7 weight 5.450
item osd.24 weight 5.450
item osd.35 weight 5.450
item osd.56 weight 5.450
item osd.77 weight 5.450
item osd.96 weight 5.450
item osd.112 weight 5.450
item osd.129 weight 5.450
item osd.147 weight 5.450
item osd.164 weight 5.450
item osd.176 weight 5.450
item osd.194 weight 5.450
item osd.209 weight 5.450
item osd.226 weight 5.450
item osd.241 weight 5.450
item osd.258 weight 5.450
item osd.275 weight 5.450
item osd.294 weight 5.450
item osd.308 weight 5.450
item osd.324 weight 5.450
item osd.342 weight 5.450
item osd.359 weight 5.450
item osd.378 weight 5.450
item osd.394 weight 5.450
item osd.409 weight 5.450
item osd.426 weight 5.450
item osd.445 weight 5.450
item osd.459 weight 5.450
item osd.477 weight 5.450
item osd.493 weight 5.450
item osd.512 weight 5.450
item osd.528 weight 5.450
item osd.547 weight 5.450
item osd.563 weight 5.450
item osd.583 weight 5.450
item osd.598 weight 5.450
}
rack 6 {
id -24 # do not change unnecessarily
# weight 392.400
alg straw
hash 0 # rjenkins1
item ss011 weight 196.200
item ss012 weight 196.200
}
root default {
id -1 # do not change unnecessarily
# weight 3531.600
alg straw
hash 0 # rjenkins1
item 1 weight 784.800
item 2 weight 784.800
item 3 weight 784.800
item 4 weight 392.400
item 5 weight 392.400
item 6 weight 392.400
}

# rules
rule replicated_ruleset {
ruleset 0
type replicated
min_size 1
max_size 10
step take default
step chooseleaf firstn 0 type rack
step emit
}

# end crush map
Matt Conner
keepertechnology
matt.conner@keepertech.com
(240) 461-2657


On Thu, Mar 19, 2015 at 11:01 AM, Sage Weil <sage@newdream.net> wrote:
> On Thu, 19 Mar 2015, Gregory Farnum wrote:
>> Can you share the actual map? I'm not sure exactly what "rack rules"
>> means here but from your description so far I'm guessing/hoping that
>> you've accidentally restricted OSD choices in a way that limits the
>> number of peers each OSD is getting.
>
> It may also be that the pg_num calculation is off.  If OSDs really have
> ~200 PGs you would expect ~200-400 peers, not ~10.  Perhaps you plugged in
> the nubmer of OSD *hosts* into your calculation instead of the number of
> disks?
>
> Either way, the 'ceph osd dump' and 'ceph osd crush dump' output should
> clear things up!
>
> sage
>
>
>> -Greg
>>
>> On Thu, Mar 19, 2015 at 5:41 AM, Matt Conner <matt.conner@keepertech.com> wrote:
>> > In this case we are using rack rules with the firefly tunables. The testing
>> > was being done with a single, 3 copy, pool with placement group number 4096.
>> > This was calculated based on 10% data and 200 PGs per OSD using the
>> > calculator at http://ceph.com/pgcalc/.
>> >
>> > Thanks,
>> > Matt
>> >
>> > Matt Conner
>> > keepertechnology
>> > matt.conner@keepertech.com
>> > (240) 461-2657
>> >
>> > On Wed, Mar 18, 2015 at 4:11 PM, Gregory Farnum <greg@gregs42.com> wrote:
>> >>
>> >> On Wed, Mar 18, 2015 at 12:59 PM, Sage Weil <sage@newdream.net> wrote:
>> >> > On Wed, 18 Mar 2015, Matt Conner wrote:
>> >> >> I'm working with a 6 rack, 18 server (3 racks of 2 servers , 3 racks
>> >> >> of 4 servers), 640 OSD cluster and have run into an issue when failing
>> >> >> a storage server or rack where the OSDs are not getting marked down
>> >> >> until the monitor timeout is reached - typically resulting in all
>> >> >> writes being blocked until the timeout.
>> >> >>
>> >> >> Each of our storage servers contains 36 OSDs, so in order to prevent a
>> >> >> server from marking a OSD out (in case of network issues), we have set
>> >> >> our "mon_osd_min_down_reporters" value to 37. This value is working
>> >> >> great for a smaller cluster, but unfortunately seems to not work so
>> >> >> well in this large cluster. Tailing the monitor logs I can see that
>> >> >> the monitor is only receiving failed reports from 9-10 unique OSDs per
>> >> >> failed OSD.
>> >> >>
>> >> >> I've played around with "osd_heartbeat_min_peers", and it seems to
>> >> >> help, but I still run into issues where an OSD is not marked down. Can
>> >> >> anyone explain how the number of heartbeat peers is determined and
>> >> >> how, if necessary, I can can use "osd_heartbeat_min_peers" to ensure I
>> >> >> have enough peering to detect failures in large clusters?
>> >> >
>> >> > The peers are normally determined why which other OSDs we share a PG
>> >> > with.
>> >> > Increasing pg_num for your pools will tend to increase this.  It looks
>> >> > like osd_heartbeat_min_peers will do the same (to be honest I don't
>> >> > think
>> >> > I've ever had to use it for this), so I'm not sure why that isn't
>> >> > resolving the problem.  Maybe make sure it is set significantly higher
>> >> > than 36?  It may simply be that several of the random choices were
>> >> > within
>> >> > the same host so that when it goes down there still aren't enough peers
>> >> > to mark things down.
>> >> >
>> >> > Alternatively, you can give up on the mon_osd_min_down_reporters tweak.
>> >> > It sounds like it creates more problems than it solves...
>> >>
>> >> This normally works out okay; in particular I'd expect a lot more than
>> >> 10 peer OSDs in a cluster of this size. What's your CRUSH map and
>> >> ruleset look like? How many pools and PGs?
>> >> -Greg
>> >
>> >
>>
>>
