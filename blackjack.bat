@echo off
title Blackjack Game

set /a deck[1]=11, deck[2]=2, deck[3]=3, deck[4]=4, deck[5]=5, deck[6]=6, deck[7]=7, deck[8]=8, deck[9]=9, deck[10]=10, deck[11]=10, deck[12]=10, deck[13]=10
set /a player_total=0
set /a dealer_total=0

:shuffle
cls
echo Shuffling the deck...
for /l %%i in (1,1,5) do (
    set /a rnd1=%random% %% 13 + 1
    set /a rnd2=%random% %% 13 + 1
    set /a temp=deck[%rnd1%]
    set deck[%rnd1%]=deck[%rnd2%]
    set deck[%rnd2%]=%temp%
)
pause

:deal
cls
echo Dealing the cards...

set /a player_total=0
set /a dealer_total=0

set /a rnd1=%random% %% 13 + 1
set /a rnd2=%random% %% 13 + 1

set /a player_card1=deck[%rnd1%]
set /a player_card2=deck[%rnd2%]

set /a player_total=%player_card1% + %player_card2%

echo Your cards: %player_card1% %player_card2% (Total: %player_total%)

set /a rnd1=%random% %% 13 + 1
set /a rnd2=%random% %% 13 + 1

set /a dealer_card1=deck[%rnd1%]
set /a dealer_card2=deck[%rnd2%]

set /a dealer_total=%dealer_card1% + %dealer_card2%

echo Dealer's cards: %dealer_card1% ? (Total: ?)

pause

:player_turn
cls
echo Your turn...

if %player_total% equ 21 (
    echo Blackjack! You win!
    goto end_game
)

echo Your cards: %player_card1% %player_card2% (Total: %player_total%)

set /p choice=Do you want to hit or stand? 

if "%choice%" equ "hit" (
    set /a rnd1=%random% %% 13 + 1
    set /a player_card3=deck[%rnd1%]
    set /a player_total=%player_total% + %player_card3%
    
    echo Your card: %player_card3% (Total: %player_total%)
    
    if %player_total% gtr 21 (
        echo Busted! You lose!
        goto end_game
    )
    
    goto player_turn
)

:dealer_turn
cls
echo Dealer's turn...

if %dealer_total% geq 17 goto compare_totals

set /a rnd1=%random% %% 13 + 1
set /a dealer_card3=deck[%rnd1%]
set /a dealer_total=%dealer_total% + %dealer_card3%

echo Dealer's card: %dealer_card3% (Total: %dealer_total%)

goto dealer_turn

:compare_totals
cls
echo Comparing totals...

echo Your cards: %player_card1% %player_card2% %player_card3% (Total: %player_total%)
echo Dealer's cards: %dealer_card1% %dealer_card2% %dealer_card3% (Total: %dealer_total%)

if %dealer_total% gtr 21 (
    echo Dealer busts! You win!
    goto end_game
)

if %dealer_total% eq %player_total% (
    echo It's a tie!
    goto end_game
)

if %dealer_total% gtr %player_total% (
    echo Dealer wins!
    goto end_game
)

echo You win!

:end_game
set /p choice=Do you want to play again? 

if "%choice%" equ "yes" goto shuffle
